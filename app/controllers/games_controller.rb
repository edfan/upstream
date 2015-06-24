class GamesController < ApplicationController

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)

    @game.save
  end

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @streams = Stream.where("game = ?", @game.name)
  end

  def search_for_name
    @games = Game.order('name').
    finder(params[:q]).page(params[:page]).per(params[:per])
    respond_to do |format|
      format.html
      format.json { render json: @games }
    end
  end

  private
  def game_params
    params.require(:game).permit(:name)
  end

end
