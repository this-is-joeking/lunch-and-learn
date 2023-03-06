class SightFacade
  def self.sights_near(lon, lat)
    sights_data = SightService.sights_near(lon, lat)
    sights_data[:features].map do |sight_data|
       TouristSight.new(sight_data)
    end
  end
end