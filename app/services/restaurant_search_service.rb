class RestaurantSearchService < ApplicationService
  class << self
    def conn
      Faraday.new("https://api.yelp.com")
    end

    def business_search(location, term, travel_time)
      categories = ["bars","restaurants"]*","
      search = conn.get("/v3/businesses/search") do |req|
        req.params[:open_at] = travel_time.arrival_time
        req.params[:term] = term
        req.params[:location] = location
        req.params[:categories] = categories
        req.headers[:Authorization] = "Bearer #{ENV["YELP_KEY"]}"
      end
      json_parse(search)[:businesses][0]
    end
  end
end
