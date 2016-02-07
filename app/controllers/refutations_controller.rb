class RefutationsController < ApplicationController
  before_action :find_speech, only: [:new]

  def new
    @refutation = @speech.contentions.build(assertion_id: params[:assertion_id])
  end

  def create
    @speech = Speech.find(params[:refutation][:speech_id])
    @refutation = @speech.contentions.build(refutation_param)

    if @refutation.save
      flash[:notice] = "Refutation saved"
      redirect_to edit_speech_path(@speech)
    else
      flash[:alert] = "Problem saving your refutation"
      render :new
    end
  end

  def edit
    @refutation = Contention.find(params[:id])
  end

  def update
    @refutation = Contention.find(params[:id])

    if @refutation.update(refutation_param)
      flash[:notice] = "Refutation updated"
      redirect_to edit_speech_path(@refutation.speech)
    else
      flash[:alert] = "Problem updating your refutation"
      render :edit
    end
  end

  def destroy
    @refutation = Contention.find(params[:contention_id])
    if @refutation.destroy
      flash[:notice] = "Refutation updated"
      redirect_to edit_speech_path(@refutation.speech)
    else
      flash[:alert] = "Problem updating your refutation"
      render :edit
    end
  end

  def find_speech
    @speech = Speech.find(params[:speech_id])
  end

  def refutation_param
    params.require(:refutation).permit(:topic, :summary, :speech_id, :assertion_id)
  end
end
