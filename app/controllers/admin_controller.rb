class AdminController < ApplicationController

  def users
    @users = User.order('created_at desc')
  end

  def new_user

  end

  def create_user
    email = params[:email]
    password = params[:password]
    password_confirmation = params[:password_confirmation]
    branch = params[:branch]
    user_role = params[:user_role]
    new_user = User.create email: email, password: password, password_confirmation: password_confirmation, branch_id: branch, user_role_id: user_role
    if new_user.id.nil?
      redirect_to '/new_user', notice: 'Algo salio mal, intenta de nuevo'
    else
      redirect_to '/users', notice: 'Usuario correctamente creado'
    end
  end

  def add_branch_to_user
    @user = User.find(params[:id])
  end

  def add_branch_to_user_post
    @user = User.find(params[:id])
    @branch = Branch.find(params[:branch_id][:branch_id])
    UserBranch.create user: @user, branch: @branch
    redirect_to '/users'
  end

  

end
