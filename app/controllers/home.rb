Automatica::App.controllers :home do
  # We capture the `omniauth.auth` response with all the details we need.
  get :auth, map: '/auth/automatic/callback' do
    omniauth_params = request.env['omniauth.auth']
    session[:automatic_omniauth_response] = request.env['omniauth.auth']
    session[:automatic_uid]         = omniauth_params['uid']
    session[:automatic_sid]         = omniauth_params['info']['id']
    session[:automatic_credentials] = omniauth_params['credentials']
    
    user = User.find_or_create_from_oauth(omniauth_params)
    current_user = user
    session[:current_user] = user.id
    configure_client
    redirect url(:home, :index)
  end

  # You rejected authorization with Automatic.
  get :auth_fail, map: '/auth/failure' do
    session.delete(:automatic_omniauth_response)

    render "index"
  end

  get :index, map: '/' do
    if signed_in?
      Automatic::Client.configure do |c|
        c.access_token = access_token
      end
    end
    render :index
  end

end
