class PositionsController < ApplicationController
  before_action :find_debate
  before_action :authenticate_user!

  def new
    @position = @debate.positions.build(affirmative: params[:affirmative], user: current_user)
  end

  def create
    @position = @debate.positions.create(position_param)

    if @position.save
      flash[:notice] = "Position saved"
      redirect_to @debate
    else
      flash[:alert] = "Problem saving your position"
      render :new
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  private
  def find_debate
    @debate = Debate.find(params[:debate_id])
  end

  def position_param
    params.require(:position).permit(:affirmative, :value, :criterion, :user_id)
  end

end
