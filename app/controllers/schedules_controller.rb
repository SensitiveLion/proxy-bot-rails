class SchedulesController < ApplicationController
  def index
    @schedule = Schedule.last
    @schedule_new = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    if @schedule.save
      flash[:notice] = "you have added a new schedule!"
      redirect_to root_path
    else
      render :index
    end
  end

  def schedule_params
    params.require(:schedule).permit(:interval, :time)
  end
end
