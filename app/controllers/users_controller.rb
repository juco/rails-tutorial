class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def create
  	@user = User.create(params[:user])
  	if @user.save
  		# Handle success
  	else
  		render 'new'
  	end
  end
end
