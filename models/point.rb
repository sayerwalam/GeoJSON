require 'sinatra/activerecord'
require 'geokit'

class Point < ActiveRecord::Base

  def self.within_radius(coordinates, radius)
    x = coordinates[0].to_f # converts the first index of the co-ordinate array to float
    y = coordinates[1].to_f # converts the second index of the co-ordinate array to float
    # This is the sql query which is using the x(square) + y(square) <= radius(square) formula to find the record which are around the radius point
    sql = "SELECT
            *
           FROM
            points
           WHERE
            (
              (#{x} - TO_NUMBER((json#>> '{coordinates, 0}'), '99G999D9S'))
                *
              (#{x} - TO_NUMBER((json#>> '{coordinates, 0}'), '99G999D9S'))
            )
              +
            (
              (#{y} - TO_NUMBER((json#>> '{coordinates, 1}'), '99G999D9S'))
                *
              (#{y} - TO_NUMBER((json#>> '{coordinates, 1}'), '99G999D9S'))
            ) <= (#{radius.to_f * radius.to_f})
           ORDER BY created_at ASC;"
    result = ActiveRecord::Base.connection.execute(sql)
    return result
  end

  def self.within_polygon(coordinates)
    polygon_points = []
    coordinates.each do |coordinate|
      # creates a new array called polygon_points using the GeoKit Lattitude longitude class
      polygon_points << Geokit::LatLng.new(coordinate.values[0], coordinate.values[1])
    end
    polygon = Geokit::Polygon.new polygon_points
    points = []
    self.all.each do |point|
      points << point if polygon.contains? Geokit::LatLng.new(point.json["coordinates"][0], point.json["coordinates"][1])
    end
    return points
  end
end
