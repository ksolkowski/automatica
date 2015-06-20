# Helper methods defined here can be accessed in any controller or view in the application

module Automatica
  class App
    module HomeHelper
      def icon_tag(icon, options={})
        """
        <i class=\"glyphicon glyphicon-#{icon} #{options.delete(:class)}\" #{options.map{|x,y| "#{x}=\"#{y}\""}.join(" ")}></i>
        """.html_safe
      end

      def current_user=(user)
        @current_user = user
      end

      def current_user
        @current_user ||= User.find_by_id(session[:current_user])
      end

      def current_user?(user)
        user == current_user
      end

      def sign_in(user)
        session[:current_user] = user.id
        self.current_user = user
      end

      def sign_out
        session.delete(:current_user)
      end

      def signed_in?
        !current_user.nil?
      end

      def automatic_credentials
        session[:automatic_credentials]
      end

      def automatic_credentials?
        automatic_credentials.present?
      end

      def configure_client
        Automatic::Client.configure do |c|
          c.access_token = access_token
        end
      end

      def access_token
        if automatic_credentials?
          automatic_credentials['token']
        else
          ENV['AUTOMATIC_ACCESS_TOKEN']
        end
      end

      def access_token?
        access_token.present?
      end
    end

    helpers HomeHelper
  end
end
