class SessionsController < ApplicationController
  before_action :redirect_if_not_logged_in, only: [:show]
  require 'securerandom'

  def destroy
    session.clear
    flash[:success] = "You have logged out"
    redirect_to '/'
  end

  def new
    @user = User.new
    render :login
  end

  def create
    user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password]) && @user.authenticate(params[:user][:password_confirmation])
      session[:user_id] = @user.id
      flash[:success] = "Welcome back #{@user.name}!"
      redirect_to user_path(@user)
    else
      flash[:error] = "Sorry, there was an error with your account!"
      redirect_to '/login'
    end
  end

   def omniauth
    user= User.from_omniauth(auth)
    if user.valid? 
      session[:user_id] = @user.id
      flash[:success] = "Welcome back #{@user.name}!"
      redirect_to user_path(@user)
    else 
      redirect to login_path
  end 

  def home
    redirect_to meal_plans_path if logged_in?
  end

  private
    def auth
      request.env['omniauth.auth']
    end
  end
end
