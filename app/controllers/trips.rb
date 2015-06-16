Automatica::App.controllers :trips do
  get :index, map: '/trips', provides: [:json] do
    render_models
  end

  get :show, with: :id, map: '/trips', provides: [:json] do
    render_model
  end

end