class DebatesController < ApplicationController
  before_action :find_debate, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @debates = Debate.all.new_to_old
  end

  def show
  end

  def new
    @debate = Debate.new
  end

  def create
    @debate = Debate.new(debate_param)
    # require a sign in in order to save or create debates

    if @debate.save
      flash[:notice] = "New debate created"
      redirect_to(@debate)
    else
      flash[:alert] = "Problem with your new debate. Please try again."
      render :new
    end
  end

  def edit
  end

  def update
    if @debate.update_attributes(debate_param)
      flash[:notice] = "Debate updated"
      redirect_to(@debate)
    else
      flash[:alert] = "Update didn't work. Please try again."
      render :edit
    end
  end

  def destroy
    if @debate
      @debate.destroy
      flash[:notice] = "Debate deleted"
      redirect_to debates_path
    else
      flash[:alert] = "Debate not found"
      redirect_to debates_path
    end
  end

  private
  def debate_param
    params.require(:debate).permit(:resolution, :creator_id)
  end

  def find_debate
    @debate = Debate.find(params[:id])
  end

end
