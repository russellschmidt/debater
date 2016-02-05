class RebuttalsController < ApplicationController
  before_action :find_debate, only: [:create, :destroy]
  before_action :find_speech, only: [:create, :destroy]
  before_action :find_speech_name, only: [:create, :destroy]

  def create
    @rebuttal = Rebuttal.new(contention: params[:contention])
    if @rebuttal.save
      flash[:notice] = "Rebuttal saved successfully"
      case @speech_name
      when 'OneNC'
        redirect_to new_speech_contention_path(@speech)
      else
        redirect_to debate_path(@debate)
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
    contention = Contention.find(params[:contention])
    speech = Speech.find(contention.speech)
    position = Position.find(speech.position)
    @debate = Debate.find(position.debate)
  end

  def find_speech
    @speech = @rebuttal.contention.speech
  end

  def find_speech_name
    @speech_name = @speech.speech_name
  end

end
