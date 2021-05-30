class ReservationsController < ApplicationController
  before_action :authenticate_user, {only: [:index, :new, :create, :show]}

  def index
  end

  def new
    @room = Room.find_by(params[:room_id])
    @reservation = Reservation.new(
      user_id: User.first.id,
      room_id: @room.id,
      start: params[:start_date],
    end: params[:end_date],
    person_count: params[:person_count]
    )
    @reservation_count = (@reservation.end - @reservation.start).to_i
    @total_price = @room.price * @reservation_count
  end

  def create
    reservation_param = params[:reservation]
    @reservation = Reservation.new(user_id: User.first.id, room_id: reservation_param[:room_id], start: reservation_param[:start_date], end: reservation_param[:end_date], person_count: reservation_param[:person_count])
    @reservation.save
    redirect_to "/reservations/#{@reservation.id}"
  end

  def show
    @reservation = Reservation.find(params[:id])
  end
end
