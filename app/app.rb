module Automatica
  class App < Padrino::Application
    register SassInitializer
    register Padrino::Mailer
    register Padrino::Helpers

    enable :sessions

    use OmniAuth::Builder do
      provider :automatic, ENV.fetch('AUTOMATIC_CLIENT_ID'), ENV.fetch('AUTOMATIC_CLIENT_SECRET'), {
        scope: 'scope:trip scope:vehicle:profile scope:public scope:user:profile', provider_ignores_state: false
      }
    end

  end
end
