Automatica::App.controllers :cars do

  # fetch from the API
  get :fetch, map: '/cars/fetch', provides: [:json] do 
    #vehicles = []
    pagination_params = {
      page: params.fetch(:page, 1),
      limit: params.fetch(:limit, 25)
    }
    vehicles_route = Automatic::Client.routes.route_for('vehicles')
    vehicles_url   = vehicles_route.url_for(pagination_params)

    vehicles_request = Automatic::Client.get(vehicles_url)
    vehicles_request.on(:success) do |resp|
      metadata = Automatic::Models::Response::Metadata.new(resp.body.fetch('_metadata', {}))
      vehicles = Automatic::Models::Vehicles.new(resp.body.fetch('results', []))
      return vehicles.to_json
    end
    vehicles_request.on(:server_error) do |resp|
      status 500
    end
  end

  get :show, map: '/cars/:id' do
    # TODO
  end

  get :index, map: '/cars' do
    # TODO
  end

  # todo get params better
  post :create, map: '/cars', csrf_protection: false, provides: [:json] do
    car_params = JSON.parse(request.body.read)
    car = Car.new(car_params)
    if car.save
      return car.to_json
    else
      return {errors: car.errors.to_json, status: 404}
    end
  end

  put :update, map: '/cars/:id' do
    # TODO
  end

  
end