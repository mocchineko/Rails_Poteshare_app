class ReservationsController < ApplicationController
  def index
    @room = Room.find_by(id: params[:id])
    @room.price = params[:price]
    @reservations = Reservations.find_by(id: params[:id])
    @total_price = @room.price * @reservations.person_num
  end

  def new
  end

  def confirm
  end
end
