class BookingForm
  include ActiveModel::Model

  validate :is_room_available?

  def initialize(room, booking_params, user_params)
    @room = room
    @start_date = booking_params[:start_date]
    @end_date = booking_params[:end_date]
    @user_params = user_params
  end

  def save
    return false if invalid?

    ActiveRecord::Base.transaction do
      new_user = User.create(@user_params)
      errors.merge! new_user.errors

      new_txn = RoomUserTxn.create(room_id: @room.id, user_id: new_user.id, start_date: @start_date,
                                   end_date: @end_date)
      errors.merge! new_txn.errors
    end

    errors.blank?
  end

  private

  def is_room_available?
    booked = @room.room_user_txn.where("(start_date >= ? and end_date <= ?) or
                                (start_date <= ? and end_date >= ?) or
                                (start_date <= ? and end_date >= ?)",
                                       @start_date, @end_date, @end_date, @end_date, @start_date, @start_date)
                                       
    return if booked.empty?

    errors.add('room', 'not available')
  end
end
