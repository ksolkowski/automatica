Automatica::App.controllers :oil_changes do
  get :index, map: '/oil_changes', provides: [:json] do
    render_models
  end

  get :show, with: :id, map: '/oil_changes', provides: [:json] do
    render_model
  end

    # todo get params better
  post :create, map: '/oil_changes', csrf_protection: false, provides: [:json] do
    oil_change_params = JSON.parse(request.body.read)
    oil_change = OilChange.new(oil_change_params)
    if oil_change.save
      return oil_change.to_json
    else
      return {errors: oil_change.errors.to_json, status: 404}
    end
  end

end