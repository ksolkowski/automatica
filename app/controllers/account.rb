Automatica::App.controllers :account do
  get :show, map: '/account' do
    pagination_params = {
      :page  => params.fetch(:page, 1),
      :limit => params.fetch(:limit, 25)
    }
    vehicles_route = Automatic::Client.routes.route_for('vehicles')
    vehicles_url   = vehicles_route.url_for(pagination_params)

    vehicles_request = Automatic::Client.get(vehicles_url)

    vehicles_request.on(:success) do |resp|
      metadata = Automatic::Models::Response::Metadata.new(resp.body.fetch('_metadata', {}))
      vehicles = Automatic::Models::Vehicles.new(resp.body.fetch('results', []))

      @vehicles = vehicles
    end

    render :show
  end

  get :fetch_vehicles, map: '/fetch_vehicles' do 
    
  end

  get :logout, map: '/logout' do
    session.delete(:current_user)
    redirect url(:home, :index)
  end
end