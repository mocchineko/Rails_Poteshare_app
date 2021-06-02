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
      thumbnail: thumbnail
      )
      if @room.save
        flash[:notice] = "ルームを登録しました"
        redirect_to("/rooms/#{@room.id}")
      else
        render("rooms/new")
      end
  end

  def show
    @room = Room.find(params[:id])
  end

  def search
    @rooms = Room.all

    if params[:area].present?
      @rooms = @rooms.where('address LIKE ?', "%#{params[:area]}%")
    end

    if params[:keyword].present?
      keyword = params[:keyword]
      @rooms = @rooms.where(['name LIKE ? OR description LIKE ?', "%#{keyword}%", "%#{keyword}%"])
    end

    @room_count = @rooms.count
  end
    
  def posts
    @rooms = Room.all.order(created_at: :desc)
  end

end
