class RoomsController < ApplicationController
  def index
  end

  def new
    @room = Room.new
  end

  def create
    @post = Post.new(
      name: params[:content],
      descripition: params[:descripition],
      price: params[:price],
      address: params[:address],
      room_name: params[:room_name]
    )
  end

  def show
  end

  def search
  end

  def reserve
  end

  def posts
  end

end
