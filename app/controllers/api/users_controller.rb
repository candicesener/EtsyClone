class Api::UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create 
        @user = User.new(user_params)
        if @user.save
            login!(@user) 
            render partial: "api/users/user", locals: { user: @user }
            
        else
            render json: ['Oops, please fill in all the fields.']

        end

    end


    def show
        @user = User.find(params[:id])

        if @user
            render "api/users/show"
        else
            render json: ['Try Again!'], status: 401
        end
    end


    private

    def user_params
        params.require(:user).permit(:firstname, :lastname, :email, :password)
    end

end
