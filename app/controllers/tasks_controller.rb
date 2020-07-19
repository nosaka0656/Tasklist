class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :show, :edit, :update]
  
  def index
    if logged_in?
      @tasks = current_user.tasks
    end
  end
  
  def show
    @task = current_user.tasks.find(params[:id])
  end
 
  def new
    @task = current_user.tasks.build
  end   
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:sucess] = "保存されました！"
      redirect_to tasks_url
    else
      flash.now[:danger] = "保存されませんでした！"
      render :new
    end
    
  end
  
  def edit
    @task = current_user.tasks.find(params[:id])
  end
  
  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
      flash[:sucess] ="更新されました！"
      redirect_to task_url(@task)
    else
      flash.now[:danger] = "更新されませんでした！"
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    flash[:sucess] = "削除されました！"
    redirect_to tasks_url
  
  end
  
  private 
  
  def task_params
    params.require(:task).permit(:content,:status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to "/"
    end
  end
end