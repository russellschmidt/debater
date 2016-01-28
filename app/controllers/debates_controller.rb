class DebatesController < ApplicationController

  def index
    @debates = Debate.all.order("updated_at DESC")
  end

  def show
    @debate = Debate.find(params[:id])
  end

  def new
    @debate = Debate.new
  end

  def create
    @debate = Debate.new(debate_param)
    # require a sign in in order to save or create debates
    if current_user
      @debate.creator = current_user
    end

    if @debate.save
      flash[:notice] = "New debate created"
      redirect_to(@debate)
    else
      flash[:alert] = "Problem with your new debate. Please try again."
      render :new
    end
  end

  def edit
    @debate = Debate.find(params[:id])
  end

  def update
    @debate = Debate.find(params[:id])

    if @debate.update_attributes(debate_param)
      flash[:notice] = "Debate updated"
      redirect_to(@debate)
    else
      flash[:alert] = "Update didn't work. Please try again."
      render :edit
    end
  end

  def destroy
    Debate.find(params[:id]).destroy
    flash[:notice] = "Debate deleted"
    redirect_to debates_path
  end

  private
  def debate_param
    params.require(:debate).permit(:resolution, :creator_id)
  end

end
