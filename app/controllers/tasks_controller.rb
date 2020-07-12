class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    @task = Task.find(params[:id])
  end
 
  def new
    @task = Task.new
  end   
  
  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:sucess] = "Success!"
      redirect_to task_url(@task)
    else
      flash.now[:danger] = "Failed!"
      render :new
    end
    
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:sucess] ="Success!"
      redirect_to task_url(@task)
    else
      flash.now[:danger] = "Failed!"
      render :edit
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:sucess] = "Success!"
    redirect_to tasks_url
  
  end
  
  private 
  
  def task_params
    params.require(:task).permit(:content)
  end
  
end
