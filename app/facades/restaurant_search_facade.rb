class RestaurantSearchFacade
  class << self
    def get_restaurant(location, search_term, travel_time)
      Restaurant.new(RestaurantSearchService.business_search(location, search_term, travel_time))
    end
  end
end
