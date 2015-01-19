class SessionsController < ApplicationController
  def new
    @twitch = Twitch.new({
      :client_id => CLIENT_ID,
      :redirect_uri => REDIRECT_URI,
      :scope => SCOPES
    })
    @url = @twitch.getLink()

    redirect_to @url
  end

  def create
    @twitch = Twitch.new({
      :client_id => CLIENT_ID,
      :secret_key => SECRET_KEY,
      :redirect_uri => REDIRECT_URI
    })

    @data = @twitch.auth(params[:code])
    session[:access_token] = @data[:body]["access_token"]

    @twitch = Twitch.new({
      :client_id => CLIENT_ID,
      :secret_key => SECRET_KEY,
      :redirect_uri => REDIRECT_URI,
      :access_token => session[:access_token]
    })
    @apiuser = @twitch.getYourUser()
    session[:name] = @apiuser[:body]["display_name"]

    puts(session[:access_token])

    @name = User.find_by_name(session[:name])
    if @name
      redirect_to '/update'
    else
      redirect_to :controller => 'users', :action => 'new'
    end
  end

  def failure
  end

  def destroy
    reset_session

    redirect_to :controller => 'users', :action => 'index'
  end
end
