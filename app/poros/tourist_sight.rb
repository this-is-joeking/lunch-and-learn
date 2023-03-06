class TouristSight
  attr_reader :id, :name, :address, :place_id
  def initialize(sight_data)
    @id = nil
    @name = sight_data[:properties][:name]
    @address = sight_data[:properties][:formatted]
    @place_id = sight_data[:properties][:place_id]
  end
end