require 'net/http'
require 'json'

def get_current_time(area, location)
  url = URI("http://worldtimeapi.org/api/timezone/#{area}/#{location}")

  begin
    response = Net::HTTP.get_response(url)

    if response.is_a?(Net::HTTPSuccess)
      data = JSON.parse(response.body)
      timezone = data['timezone']
      date_str = data['datetime'].split('T')[0]
      time_str = data['datetime'].split('T')[1].split('.')[0]

      puts "The current time in #{timezone} is #{date_str} #{time_str}"
    else
      puts "Error occurred while fetching time (HTTP #{response.code})"
    end
  rescue StandardError => e
    puts "Error occurred: #{e.message}"
  end
end

get_current_time("Europe", "Rome")
