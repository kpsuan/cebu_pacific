class FlightsController < ApplicationController
  def index
    @airports = Airport.order(:code)

    # Dates that actually have flights (as Date objects)
    @available_dates = Flight
    .select("DATE(start_time) AS flight_date")
    .distinct
    .order("flight_date")
    .map { |f| f.flight_date }


    @flights = []
    if params[:departure_airport_id].present? &&
       params[:arrival_airport_id].present?   &&
       params[:date].present?
      date = Date.parse(params[:date]) rescue nil
      if date
        @flights = Flight
          .where(departure_airport_id: params[:departure_airport_id],
                 arrival_airport_id:   params[:arrival_airport_id])
          .where("DATE(start_time) = ?", date)
          .order(:start_time)
      end
    end
  end
end
