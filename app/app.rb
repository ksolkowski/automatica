module Automatica
  class App < Padrino::Application
    register CoffeeInitializer
    register SassInitializer
    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Sprockets
    sprockets

    # TODO http://www.bactrack.com/pages/api-docs
    #  def json_resource
    #  return @json_resource if @json_resource
    #  if request.body.size > 0
    #  request.body.rewind
    #  @json_resource = JSON.parse(request.body.read)

      # non editable fields
    #  @json_resource.delete("id")
    #  @json_resource.delete("updated_at")
    #  @json_resource.delete("created_at")
    #  end
    #  @json_resource ||= {}
    #  end

    enable :sessions

    use OmniAuth::Builder do
      provider :automatic, ENV.fetch('AUTOMATIC_CLIENT_ID'), ENV.fetch('AUTOMATIC_CLIENT_SECRET'), {
        scope: 'scope:trip scope:vehicle:profile scope:public scope:user:profile scope:behavior scope:vehicle:events', 
        provider_ignores_state: false
      }
    end

  end
end
