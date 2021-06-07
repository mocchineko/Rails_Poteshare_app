class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:profile, :profile_update, :edit, :account, :account_update, :logout]}

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
      password: params[:password],
      check_account: true
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

  def account
  end

  user_params = params[:user]
    @user = User.find_by(email: user_params[:email])
    if @user && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      redirect_to("/")
    else
      @email = params[:email]
      @password = params[:password]
      flash.now[:alert] = "Invalid Email or password."
      render "login_form"
    end
  end

  def account_update
    password = params[:password]
    password_confirmation = params[:password_confirmation]
    current_password = params[:current_password]

    # @current_user.authenticate(password) では？
    # DBの暗号化された値と == で比較しても一致しない
    # 一致してないからsaveが実行されなくて、エラーも入ってない
    if @current_user && @current_user.authenticate(password)

      if password == password_confirmation
        @current_user.password = params[:password]
        # @current_userじゃない？
        # 値を代入しないと、更新する項目がないから何も実行されない
          if @current_user.save
            flash[:notice] = "Your account has been updated successfully."
            redirect_to("/")
          end
      else
        render("users/edit")
      end
    end

  def profile
  end

  def profile_update
    @current_user.check_profile = true

    if params[:user][:image].present?
      uploaded_file = params[:user][:image]
      upload_path = File.join("uploads_user_icons", uploaded_file.original_filename)
      File.open(Rails.root.join("public", upload_path), 'w+b') do |fp|
        fp.write  uploaded_file.read
      end
      icon = File.join("/", upload_path)
      @current_user.icon = icon
      @current_user.name = params[:user][:name]
      @current_user.introduce = params[:user][:introduction]
    end

    if @current_user.save
      flash[:notice] = "Profile was successfully updated."
      redirect_to("/users/profile")
    else
      puts @current_user.inspect
      puts @current_user.errors.full_messages
      render("users/profile")
    end
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
      flash.now[:alert] = "Invalid Email or password."
      render "login_form"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to("/")
  end
end
