class ArgumentsController < ApplicationController
  before_action :find_contention, only: [:new, :create]

  def new
    @argument = @contention.argument.build
  end

  def create
    @argument = @contention.argument.create(argument_param)

    if @contention.save
      flash[:notice] = "Position saved"
      redirect_to debate_path(@speech.position.debate)
    else
      flash[:alert] = "Problem saving your position"
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def argument_param
    params.require(:argument).permit(:claim, :warrant, :impact, :citation, :contention_id)
  end

  def find_contention
    @contention = Contention.find(params[:contention_id])
  end

end
