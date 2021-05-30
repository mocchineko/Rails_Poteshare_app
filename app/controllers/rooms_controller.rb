class RoomsController < ApplicationController
  before_action :authenticate_user, {only: [:new, :create, :posts]}
  
  def index
    @rooms =Room.all
  end

  def new
    @room = Room.find_by(id: params[:id])
  end

  def create
    
    if params[:thumbnail].present?
      uploaded_file = params[:thumbnail]
      upload_path = File.join("uploads_room_images", uploaded_file.original_filename)
      File.open(Rails.root.join("public", upload_path), 'w+b') do |fp|
        fp.write  uploaded_file.read
      end
      thumbnail = File.join("/", upload_path)
    end

    @room = Room.new(
      name: params[:name],
      description: params[:description],
      price: params[:price],
      address: params[:address],
      thumbnail: thumbnailquit
      )
      if @room.save
        flash[:notice] = "ルームを登録しました"
        redirect_to("/rooms/#{@room.id}")
      else
        render("rooms/new")
      end
  end

  def show
    @room = Room.find_by(id: params[:id])
  end

  def search
    if params[:area].present?
      @rooms = Room.where('address LIKE ?', "%#{params[:area]}}%")
    elsif
      @rooms = Room.where(['address LIKE ? OR name LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      @rooms = Room.none
    end

    @room_count = @rooms.count
  end
    # そもそもの動き
    # エリアで検索した後、さらにその結果をキーワードで絞り込む流れになるのでは？
    # 現在はエリアとキーワードそれぞれで検索して、それぞれの結果を表示している

    # 検索結果の件数を表示したいので、allは間違い。これだと全権出てしまう

    def posts
      @rooms = Room.all.order(created_at: :desc)
    end

end
