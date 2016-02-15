# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    def disconnect
      # puts "\n\n in disconnect callback >>>>>>>>>>>>>>"
    end

    protected
      def find_verified_user
        auth_token = request.params[:auth_token]
        user = nil
        if auth_token.present?
          user = Knock::AuthToken.new(token: auth_token).current_user
        end
        user || reject_unauthorized_connection
      end
  end
end
