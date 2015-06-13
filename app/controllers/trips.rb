Automatica::App.controllers :trips do
  get :index, map: '/trips', provides: [:json] do
    puts params.inspect
    pagination_params = {
      page: params.fetch("page", 1),
      limit: params.fetch("limit", 25),
      vehicle: params[:car_id]
    }

    trips_route = Automatic::Client.routes.route_for('trips')
    trips_url   = trips_route.url_for(pagination_params)

    trips_request = Automatic::Client.get(trips_url)
    trips_request.on(:success) do |resp|
      metadata = Automatic::Models::Response::Metadata.new(resp.body.fetch('_metadata', {}))
      trips    = Automatic::Models::Trips.new(resp.body.fetch('results', []))

      return trips.to_json
    end

    trips_request.on(:server_error) do |resp|
      status 500
    end
  end
end