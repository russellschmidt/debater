class SpeechesController < ApplicationController

  def new
    @speech = Speech.new(speech_name: params[:speech_name], position_id: params[:position])
    @dropdown_options = Speech.speech_names.map {|key, value| [key, key]}
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

  def destroy
  end

  private

  def speech_param
    params.require(:speech).permit(:speech_name, :position_id)
  end

end
