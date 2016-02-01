class ContentionsController < ApplicationController
  before_action :find_speech, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_contention, only: [:edit, :update, :destroy]

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
    @contention = @speech.contentions.find(params[:id])
  end

  def update
    if @contention.update_attributes(contention_param)
      flash[:notice] = "Update successful"
      redirect_to edit_speech_path(@speech)
    else
      flash[:error] = "Update failed. Please try again"
      render :edit
    end
  end

  def destroy
    if @contention.destroy
      flash[:notice] = "Deletion successful"
      redirect_to edit_speech_path(@speech)
    else
      flash[:error] = "Delete failed. Please try again"
      render :edit
    end
  end

  private
  def find_speech
    @speech = Speech.find(params[:speech_id])
  end

  def find_contention
    @contention = @speech.contentions.find(params[:id])
  end

  def contention_param
    params.require(:contention).permit(:topic, :summary, :speech_id)
  end
end
