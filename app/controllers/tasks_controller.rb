  
class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show,:edit, :destroy]
  
  def index
    if logged_in?
      puts 'ログインできています。'
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    else
      flash.now[:danger] = 'ユーザ登録してください'
      redirect_to login_url
    end
  end

  def show
  end

  def new
    if logged_in?
      @task = Task.new
    else
      flash.now[:danger] = 'ログイン/ユーザー登録してください'
      redirect_to root_url
    end
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      flash[:success] = 'タスクが正常に保存されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが保存されませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'タスクが正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy

    flash[:success] = 'タスクは正常に削除されました'
    redirect_to tasks_url
  end
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end
  
  private

  # Strong Parameter
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    if logged_in?
      @task = current_user.tasks.find_by(id: params[:id])
      unless @task
        redirect_to root_url
      end
    else
      redirect_to root_url
    end
    
  end
end