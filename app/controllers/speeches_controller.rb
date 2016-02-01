class SpeechesController < ApplicationController
  before_action :dropdown, only: [:new, :edit]
  before_action :find_speech, only: [:edit, :update, :destroy]

  def new
    @speech = Speech.new(speech_name: params[:speech_name], position_id: params[:position])
  end

  def create
    @speech = Speech.new(speech_param)

    if @speech.save
      flash[:notice] = "Speech saved"
      redirect_to debate_path(@speech.position.debate)
    else
      flash[:alert] = "Problem saving your speech"
      render :new
    end
  end

  def edit
  end

  def update
    if @speech.update_attributes(speech_param)
      flash[:notice] = "Update successful"
      redirect_to debate_path(@speech.position.debate)
    else
      flash[:error] = "Update failed. Please try again"
      render :edit
    end
  end

  def destroy
    if @speech.destroy
      flash[:notice] = "Deletion successful"
      redirect_to debate_path(@speech.position.debate)
    else
      flash[:error] = "Delete failed. Please try again"
      render :edit
    end
  end


  private

  def speech_param
    params.require(:speech).permit(:speech_name, :position_id)
  end

  def dropdown
    @dropdown_options = Speech.speech_names.map {|key, value| [key, key]}
  end

  def find_speech
    @speech = Speech.find(params[:id])
  end
end
