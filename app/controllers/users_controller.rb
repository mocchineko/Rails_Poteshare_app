class UsersController < ApplicationController

  def new
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      image_name: "room01.jpg"
    )
  end

  def edit
  end

  def update
  end

  def account
  end

  def profile
  end

  def login_form
  end

  def login
  end

  def logout
  end


end
