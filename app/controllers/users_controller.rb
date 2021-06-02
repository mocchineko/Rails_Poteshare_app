class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:update, :edit, :account, :profile]}

  before_action :forbid_login_user, {only: [:new, :create, :login, :login_form]}

  def new
    @user = User.new
  end

  def create
    if params[:icon].present?
      uploaded_file = params[:icon]
      upload_path = File.join("uploads_user_icons", uploaded_file.original_filename)
      File.open(Rails.root.join("public", upload_path), 'w+b') do |fp|
        fp.write  uploaded_file.read
      end
      icon = File.join("/", upload_path)
    end

    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password]
    )
    if @user.save
      session[:user_id] = @user.id
      redirect_to("/users/profile")
    else
      render("users/new")
    end
  end

  def edit
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.email = params[:email]
    @user.password = params[:password]

    if params[:image]
      @user.icon = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/uploads_user_icons/#{@user.icon}", image.read)
    end

    if @user.save
      redirect_to("/")
    else
      render("users/edit")
    end
  end

  def account
  end

  def profile
  end

  def login_form
  end

  def login
    user_params = params[:user]
    @user = User.find_by(email: user_params[:email])
    if @user && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      redirect_to("/")
    else
      @email = params[:email]
      @password = params[:password]
      render "login_form"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to("/")
  end
end
