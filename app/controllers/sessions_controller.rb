class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by_email(params[:session][:email].downcase)
		if user and user.authenticate params[:session][:password]
			redirect_to "/users/" + user.id.to_s
		else
			flash.now[:error] = "The username and/or password are incorrect"
			render :new
		end
	end

	def destroy
		# sign_out
		# redirect_to root_path
	end
end
