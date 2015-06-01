class StreamsController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @stream = Stream.new
  end

  def create
    @user = User.find(params[:user_id])
    if params.has_key?(:stream)
      @stream = @user.streams.create(stream_params)

      @game = Game.find_by_id(@stream.game.to_i)
      @stream.game = @game.name
      @stream.save!

      @stream.delay.deleteWhenFinished
      if @stream.tweet != nil
        @stream.delay.tweetAtStart
      end
      redirect_to user_stream_path(@user, @stream)
    else
      render 'new'
    end
  end

  def show
    @stream = Stream.find(params[:id])
    @user = User.find(@stream.user_id)
  end

  def edit
    @stream = Stream.find(params[:id])
    @user = User.find(@stream.user_id)
  end

  def update
    @stream = Stream.find(params[:id])
    @user = User.find(@stream.user_id)

    @stream.update(stream_params)
    redirect_to user_stream_path(@user, @stream)
  end

  def destroy
    @stream = Stream.find(params[:id])
    @user = User.find(@stream.user_id)
    @stream.destroy

    redirect_to url_for(@user)
  end

  private
  def stream_params
    params.require(:stream).permit(:description, :tweet, :title, :game, :starttime, :endtime)
  end

end
