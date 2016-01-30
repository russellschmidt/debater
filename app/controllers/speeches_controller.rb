class SpeechesController < ApplicationController
  before_action :find_debate

  def new
    @speech = @debate.speeches.build(name: params[:name], position: params[:position])
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def find_debate
    @debate = Debate.find(params[:debate_id])
  end

end
