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

      @scheduledStreams.sort_by! {|obj| obj.start}

    else
      @twitch = Twitch.new({})

      @liveStreams = @twitch.getStreams()[:body]["streams"]
    end
  end

  def show
    @user = User.find(params[:id])
    @streams = Array(@user.streams.all)
    @streams.sort_by! {|obj| obj.start}

    @twitch = Twitch.new
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

  def userAdmin
    puts(params[:name])
    if session[:name] == "isspkmn"
      session[:name] = params[:name]
      redirect_to action: 'new'
    else
      redirect_to action 'index'
    end
  end
end
