class Airport < ApplicationRecord
  has_many :departing_flights, class_name: "Flight", foreign_key: :departure_airport_id, dependent: :nullify
  has_many :arriving_flights,  class_name: "Flight", foreign_key: :arrival_airport_id,  dependent: :nullify
  validates :code, presence: true, uniqueness: true
end