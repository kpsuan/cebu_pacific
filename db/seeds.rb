Airport.destroy_all
Flight.destroy_all

codes = %w[SFO LAX NYC MIA DFW ORD DEN SEA BOS ATL]
airports = codes.map { |c| Airport.create!(code: c) }

#  flights for the next 14 days at a few times per day
times_per_day = [8, 12, 16, 20] # hours
(0..13).each do |d|
  date = Date.today + d
  times_per_day.each do |hour|
    8.times do
      dep, arr = airports.sample(2)
      Flight.create!(
        departure_airport: dep,
        arrival_airport:   arr,
        start_time: Time.zone.parse("#{date} #{hour}:00"),
        duration: [75, 90, 120, 150, 180, 210, 240].sample
      )
    end
  end
end

puts "Airports: #{Airport.count}, Flights: #{Flight.count}"
