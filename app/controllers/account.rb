Automatica::App.controllers :account do
  get :show, map: '/account' do
    @cars = current_user.cars
    render :show
  end

  get :logout, map: '/logout' do
    session.delete(:current_user)
    session.delete(:automatic_credentials)
    redirect url(:home, :index)
  end
end