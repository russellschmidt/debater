class ArgumentsController < ApplicationController
  before_action :find_argument, only: [:edit, :update, :destroy]

  def new
    @argument = Argument.new(contention_id: params[:contention])
  end

  def create
    @argument = Argument.new(argument_param)

    if @argument.save
      flash[:notice] = "Position saved"
      redirect_to edit_speech_path(@argument.contention.speech)
    else
      flash[:alert] = "Problem saving your position"
      render :new
    end
  end

  def edit
  end

  def update
    if @argument.update(argument_param)
      flash[:notice] = "Update successful"
      redirect_to edit_speech_path(@argument.contention.speech)
    else
      flash[:error] = "Update failed. Please try again"
      render :edit
    end
  end

  def destroy
    if @argument.destroy
      flash[:notice] = "Deletion successful"
      redirect_to edit_speech_path(@argument.contention.speech)
    else
      flash[:error] = "Delete failed. Please try again"
      render :edit
    end
  end

  private
  def argument_param
    params.require(:argument).permit(:claim, :warrant, :impact, :citation, :contention_id)
  end

  def find_argument
    @argument = Argument.find(params[:id])
  end

end
