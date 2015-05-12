class WeeklyStreamsController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @stream = WeeklyStream.new
  end

  def create
    @user = User.find(params[:user_id])
    if params.has_key?(:weekly_stream)
      @stream = @user.weekly_streams.create(weekly_stream_params)

      @game = Game.find_by_id(@stream.game.to_i)
      @stream.game = @game.name
      @stream.save!

      @stream.weeklyCreate

      redirect_to user_weekly_stream_path(@user, @stream)
    else
      render 'new'
    end
  end

  def show
    @stream = WeeklyStream.find(params[:id])
    @user = User.find(@stream.user_id)
  end

  def edit
    @stream = WeeklyStream.find(params[:id])
    @user = User.find(@stream.user_id)
  end

  def update
    @stream = WeeklyStream.find(params[:id])
    @user = User.find(@stream.user_id)

    @stream.update(stream_params)
    redirect_to user_stream_path(@user, @stream)
  end

  def destroy
    @stream = WeeklyStream.find(params[:id])
    @user = User.find(@stream.user_id)
    @stream.destroy

    redirect_to url_for(@user)
  end


  private
  def weekly_stream_params
    params.require(:weekly_stream).permit(:description, :title, :game, :starttime, :endtime, :day, :tweet)
  end


end
