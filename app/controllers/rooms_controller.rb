class RoomsController < ApplicationController
  def index
    @rooms =Room.all
  end

  def new
    @room = Room.find_by(id: params[:id])
  end

  def create
    
    if params[:room_name].present?
      uploaded_file = params[:room_name]
      upload_path = File.join("uploads_room_images", uploaded_file.original_filename)
      File.open(Rails.root.join("public", upload_path), 'w+b') do |fp|
        fp.write  uploaded_file.read
      end
      room_name = File.join("/", upload_path)
    end

    @room = Room.new(
      name: params[:name],
      description: params[:description],
      price: params[:price],
      address: params[:address],
      room_name: room_name
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
    @rooms = Room.all.order(created_at: :desc)
  end

  def reserve
  end

  def posts
    @rooms = Room.all.order(created_at: :desc)
  end

end
