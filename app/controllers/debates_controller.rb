class DebatesController < ApplicationController
  before_action :ready_debate, only: [:show, :edit, :update, :destroy]

  def index
    @debates = Debate.all
  end

  def show
  end

  def new
    @debate = Debate.new
  end

  def create
    @debate = Debate.new(debate_params)

    if @debate.save
      flash[:notice] = "Debate was created"
      redirect_to @debate
    else
      flash.now[:alert] = "Error creating debate - please try again"
      render :edit
    end
  end

  def edit
  end

  def update
    @debate.update_attr(debate_params)

    if @debate.save
      flash[:notice] = "Debate was updated"
      redirect_to @debate
    else
      flash.now[:alert] = "Error saving - please try again"
      render :edit
    end
  end

  def destroy
    #only if user is admin
  end


  private
  def ready_debate
    @debate = Debate.find(params[:id])
  end

  def debate_params
    params.require(:debate).permit(:title, :topic)
  end

end
