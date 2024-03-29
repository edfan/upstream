class UsersController < ApplicationController

  def new
    @user = User.new
    @user.name = session[:name]

    @twitch = Twitch.new({
      :access_token => session[:access_token]
    })

    @apifollowing = @twitch.getAllFollows(@user.name)
    @following = []
    @apifollowing[:body]["follows"].each do |channel|
      if User.find_by_name(channel["channel"]["display_name"])
        @following.push(channel["channel"]["display_name"])
      end
    end

    @user.follows = @following

    @user.save
    redirect_to action: 'index'
  end

  def index
    @user = User.find_by_name(session[:name])

    if @user
      @twitch = Twitch.new({
        :access_token => session[:access_token]
      })

      @liveStreams = @twitch.getYourFollowedStreams()[:body]["streams"]

      @scheduledStreams = []

      @user.follows.each do |streamer|
        @dbstreamer = User.find_by_name(streamer)
        @scheduledStreams.concat(@dbstreamer.streams.all)
      end

      @scheduledStreams.sort_by! {|obj| obj.starttime}

    else
      @twitch = Twitch.new({})

      @liveStreams = @twitch.getStreams()[:body]["streams"]
    end
  end

  def show
    @user = User.find(params[:id])
    @streams = Array(@user.streams.all)
    @streams.sort_by! {|obj| obj.starttime}

    @weeklyStreams = Array(@user.weekly_streams.all)

    @twitch = Twitch.new
    @tuser = @twitch.getUser(@user.name)
    @logo = @tuser[:body]["logo"]
    @description = @tuser[:body]["bio"]

    @following = @twitch.getAllFollows(@user.name)[:body]["follows"]
    @followers = @twitch.getAllFollowing(@user.name)[:body]["follows"]

    puts(@following, @followers)

    @userStream = @twitch.getStream(@user.name)[:body]

  end

  def updateFollows
    @user = User.find_by_name(session[:name])

    @twitch = Twitch.new({
      :access_token => session[:access_token]
    })

    @apifollowing = @twitch.getAllFollows(@user.name)
    @following = []
    @apifollowing[:body]["follows"].each do |channel|
      if User.find_by_name(channel["channel"]["display_name"])
        @following.push(channel["channel"]["display_name"])
      end
    end

    @user.follows = @following

    @user.save
    redirect_to action: 'index'
  end

  def search
    @searchUsers = User.search do
      fulltext params[:search]
    end
    @users = @searchUsers.results

    @searchGames = Game.search do
      fulltext params[:search]
    end
    @games = @searchGames.results

    @searchStreams = Stream.search do
      fulltext params[:search]
    end
    @streams = @searchStreams.results
  end

  def addTwitter
    @user = User.find_by_name(session[:name])
    auth = request.env["omniauth.auth"]

    @user.token = auth[:credentials][:token]
    @user.secret = auth[:credentials][:secret]

    @user.save!

    redirect_to user_path(@user)
  end

end
