require 'omniauth-google-oauth2'

module OmniAuth
  module Strategies
    class GoogleAdwordsOauth2 < OmniAuth::Strategies::GoogleOauth2

      option :name, 'google_adwords_oauth2'

      option :skip_friends, true

      option :authorize_options, [:access_type, :hd, :login_hint, :prompt, :request_visible_actions, :scope, :state, :redirect_uri, :include_granted_scopes]

      option :client_options, {
        :site          => 'https://accounts.google.com',
        :authorize_url => '/o/oauth2/auth',
        :token_url     => '/o/oauth2/token'
      }

      option :adwords_api_config, 'adwords_api.yml'
      option :adwords_api_version, :v201409

      def authorize_params
        super.tap do |params|
          raw_scope = params[:scope]
          scope_list = raw_scope.split(" ").map {|item| item.split(",")}.flatten
          scope_list << 'adwords' unless scope_list.include?('adwords')
          scope_list.map! { |s| s =~ /^https?:\/\// || BASE_SCOPES.include?(s) ? s : "#{BASE_SCOPE_URL}#{s}" }
          params[:scope] = scope_list.join(" ")
        end
      end

      extra do
        hash = {}
        hash[:id_token] = access_token['id_token']
        hash[:raw_info] = raw_info
        hash[:raw_info][:adwords] = adwords_info
        hash[:raw_info][:token] = raw_token
      end

      attr_accessor :raw_token

      def build_access_token
        adwords_api.logger = Rails.logger
        self.raw_token = adwords_api.authorize(oauth2_callback: callback_url, oauth2_verification_code: request.params['code'])
        self.access_token = ::OAuth2::AccessToken.from_hash client, raw_token.dup # dup somehow important!
      end

      def adwords_info
        adwords_api.service(:CustomerService, options.adwords_api_version).get()
      end

      def adwords_api
        @adwords_api ||= AdwordsApi::Api.new options.adwords_api_config
      end

    end
  end
end
