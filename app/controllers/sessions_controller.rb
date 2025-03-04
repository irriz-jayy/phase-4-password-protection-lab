class SessionsController < ApplicationController
    skip_before_action :authorize, only: [:create]
   def create
    byebug
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: {error: "Invalid username or password"}, status: 401
        end
    end

  def destroy
      user =User.find(session[:user_id])
      session.delete :user_id
      head :no_content
  end
end