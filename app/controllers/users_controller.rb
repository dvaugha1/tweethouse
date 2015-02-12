class UsersController < ApplicationController
  before_action :authenticate_user!, :only => [:destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

	def index
		@users = User.all
		render :index
	end

	def destroy
		@user = User.find(params[:id])
		if current_user && (current_user.admin? || current_user == @user)
		  @user.destroy
		  redirect_to users_path, notice: "User was deleted."
		else
			flash[:alert] = "You are only allowed to delete your own account."
			redirect_to :root
		end
	end

	def new
		@user = User.new
	end

	def create
		@user = User.create(user_params)
		redirect_to :action => :index
	end

  def followers
    other_user =User.find(params[:user_id])
    current_user.follows?(other_user)
  end


	private
  def set_user
    @user = User.find params[:id]
  end

	def user_params
		params.require(:user).permit(:username, :password)
	end
end
