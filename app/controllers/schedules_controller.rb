class SchedulesController < ApplicationController
  def index
    @schedule = Schedule.last
    @schedule_new = Schedule.new
  end

  def create
    @schedule = schedule.new(schedule_params)
    @schedule.user = current_user
    if @schedule.save
      flash[:notice] = "you have added a new schedule!"
      redirect_to homes_path
    else
      render :index
    end
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      flash[:notice] = "you have successfully edited the schedule!"
      redirect_to @schedule
    else
      flash[:notice] = "failed to update schedule"
      render :index
    end
  end

  def destroy
    if current_user.has_authority?
      @schedule = Schedule.find(params[:id])
    else
      @schedule = Schedule.find_by!(user: current_user, id: params[:id])
    end
    @schedule.destroy
    flash[:notice] = 'schedule deleted.'
    redirect_to root_path
  end

  def schedule_params
    params.require(:schedule).permit(:interval, :time)
  end
end
