module Devise
  module Strategies
    class MultipleTokensStrategy < Devise::Strategies::Base

      def valid?
        params[:auth_token]
      end

      def authenticate!
        user_token = ::UserAuthenticationToken.find_by_token(params[:auth_token])
        if user_token
          user = User.find_by_id(user_token.user_id)
          if user
            success!(user)
          end
        end

        if (!(params[:user]) && !halted?)
          fail!("Invalid authentication token.")
        end
      end
    end
  end
end