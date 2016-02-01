class ContentionsController < ApplicationController
  before_action :find_speech, only: [:new, :create, :edit, :update, :destroy]

  def new
    @contention = @speech.contentions.build
  end

  def create
    @contention = @speech.contentions.create(contention_param)

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
  def find_speech
    @speech = Speech.find(params[:speech_id])
  end

  def contention_param
    params.require(:contention).permit(:topic, :summary, :speech_id)
  end
end
