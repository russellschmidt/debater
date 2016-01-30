class SpeechesController < ApplicationController
  before_action :find_debate

  def new
    @speech = @debate.speeches.build(speech_name: params[:speech_name], position: params[:position])
    @dropdown_options = Speech.speech_names
  end

  def create
  end

  def destroy
  end

  private

  def find_debate
    @debate = Debate.find(params[:debate_id])
  end

end
