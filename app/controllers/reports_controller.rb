class ReportsController < ApplicationController
  def index
    @pay_stubs = PayStub.order(:employee_id, pay_period_start_date: :DESC)
  end

  def upload
    if params[:file].blank?
      flash[:alert] = 'File Missing!'
    else
      if Report.upload(params[:file]) == true
        flash[:notice] = 'Report Uploaded'
      else
        flash[:alert] = 'Report ID Exists!'
      end
    end
    redirect_to root_url
  end
end
