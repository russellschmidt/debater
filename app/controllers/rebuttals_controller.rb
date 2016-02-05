class RebuttalsController < ApplicationController
  def create
    @rebuttal = Rebuttal.new(params[:rebuttal])
    if @rebuttal.save
      flash[:notice] = "Rebuttal saved successfully"
      redirect to debates_path
    else
      flash[:alert] = "Error saving rebuttal"
      render :new
    end
  end

  def destroy
    @rebuttal = Rebuttal.find(params[:id])
    if @rebuttal.destroy
      flash[:notice] = "Rebuttal deleted"
      redirect to debates_path
    else
      flash[:alert] = "Error deleting rebuttal"
      render :back
    end
  end
end
