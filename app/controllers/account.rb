Automatica::App.controllers :account do
  get :index, map: '/account' do
    @cars = current_user.cars
    render :index
  end

  get :logout, map: '/logout' do
    session.delete(:current_user)
    session.delete(:automatic_credentials)
    redirect url(:home, :index)
  end
end