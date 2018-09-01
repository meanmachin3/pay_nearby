class Booking < ApplicationRecord

    belongs_to :room
    belongs_to :user

    ROOM_TYPES = ['Deluxe Rooms', 'Luxury Rooms', 'Luxury Suites', 'Presidential Suites'].freeze
    before_validation :available
    validate :valid_last_and_start_date
    validates :user_id, :start_date, :last_date, presence: true

    def valid_last_and_start_date 
        if invalid_dates?
          return true
        elsif Date.today > start_date.to_date
          errors.add(:start_date, "We do not offer booking in past :)")
        elsif Date.today + 6.months < last_date.to_date 
          errors.add(:last_date, "You may book only for 6 months :)")
        elsif last_date.to_date < start_date.to_date
          errors.add(:last_date, "Invalid Checkout Date")
        end
    end

    def self.booked(start_date,last_date)
        if (booked = Booking.where("Date(start_date) < ? AND Date(last_date) > ? ", last_date,start_date).collect(&:room_id)).empty?
          return false
        else
          return booked
        end
      end

    def available
        if invalid_dates?
          return true
        elsif (rooms = Room.find_rooms(start_date, last_date, room_type).limit(1)).length > 0
            self.room_id = rooms.first.id
        else
            errors.add(:room_id, "Rooms are not available")
        end
      end

      def invalid_dates?
        if start_date.blank? || last_date.blank?
          return true
        end
      end

end
