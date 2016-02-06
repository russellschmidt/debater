class RefutationsController < ApplicationController
  before_action :find_speech, only: [:new, :create]

  def new
    @refutation = @speech.contentions.build(assertion_id: params[:contention_id])
  end

  def create
    @refutation = @speech.contention.create(refutation_param)

    if @refutation.save
      flash[:notice] = "Refutation saved"
      redirect_to edit_speech_path(@speech)
    else
      flash[:alert] = "Problem saving your refutation"
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def find_speech
    @speech = Speech.find(params[:speech])
  end

  def refutation_param
    params.require(:refutation).permit(:topic, :summary, :speech_id, :assertion_id)
  end
end
