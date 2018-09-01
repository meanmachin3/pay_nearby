class Room < ApplicationRecord
    has_and_belongs_to_many :bookings

    # Returns list of rooms that have not been booked
    def self.find_rooms(start_date, last_date, room_type)
        booked = Booking.booked(start_date, last_date)
        if booked
            self.where(room_type: room_type).where.not(id: booked)
        else
            self.where(room_type: room_type)
        end
    end
end
