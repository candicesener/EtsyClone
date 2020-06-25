class Api::SessionsController < ApplicationController
    def create
        @user = User.find_by_credentials(
            params[:user][:email],
            params[:user][:password])

    if @user
      login!(@user)
      

    else
      render json: ['Invalid username or password. Please Try Again!'], status: 401
    end
  end



end
