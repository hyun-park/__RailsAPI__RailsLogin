class UsersController < ApplicationController
  def signup
      @user = User.new
      @user.username = params[:username]
      @user.password = params[:password]
      @user.save
      
      render json: @user, status: :ok
  end
end
