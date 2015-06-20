Automatica::App.controllers :templates do
  before do
    # wait why isn't that xhr?
    #halt 422, "Unprocessable Entity" unless request.xhr?
  end

  get :index, map: '/*path', priority: :low do
    render Pathname.new(File.join(params[:path])), layout: false
  end
end