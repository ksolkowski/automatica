Automatica::App.controllers :trips do
  get :index, map: '/trips' do
    redirect url(:home, :index) if !current_user
    render "index"
  end
end