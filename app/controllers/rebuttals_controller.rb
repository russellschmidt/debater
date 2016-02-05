class RebuttalsController < ApplicationController
  before_action :find_debate, only: [:create, :destroy]

  def create
    @rebuttal = Rebuttal.new(contention_id: params[:contention_id])
    if @rebuttal.save
      flash[:notice] = "Rebuttal saved successfully"
      if is_affirmative?
        redirect_to new_speech_contention(@debate.positions.neg.first.speeches.first)
      else
        redirect_to new_speech_contention(@debate.positions.aff.first.speeches.first)
      end
    else
      flash[:alert] = "Error saving rebuttal"
      render :new
    end
  end

  def destroy
    @rebuttal = Rebuttal.find(params[:id])
    if @rebuttal.destroy
      flash[:notice] = "Rebuttal deleted"
      redirect_to debate_path(@debate)
    else
      flash[:alert] = "Error deleting rebuttal"
      render :back
    end
  end

  private
  def find_debate
    @debate = params[:debate_id]
  end

  def is_affirmative?
    @affirmative = params[:affirmative]
  end
end
