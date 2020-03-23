require './models/point'

post '/push' do
  # creates a new array called polygon_points using the GeoKit Lattitude longitude class
  point = Point.create(json: {type: params[:type], coordinates: params[:coordinates].values})
  if !point.errors.empty?
    return point.errors.messages
  else
    return point.to_json
  end
end

get '/radius' do
  # Fires the query using the within_radius method defined in models/point.rb file and returns the result
  points = Point.within_radius(params[:coordinates].values, params[:radius])
  return points.as_json.to_json
end

get '/polygon' do
  #Fires the query using the within_polygon method defined in models/point.rb file and return the results
  points = Point.within_polygon(params[:coordinates]["0"].values)
  return points.as_json.to_json
end
