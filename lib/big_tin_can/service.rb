module BigTinCan
  class Service
    include HTTParty
    include BigTinCan::API

    PERMITTED_OPTIONS = %i{client_id client_secret api_key}.freeze

    attr_accessor :access_token, :rate_limit, :rate_limit_remaining
    base_uri 'https://pubapi.bigtincan.com/services'

    def initialize(access_token = nil)
      @access_token = access_token || BigTinCan.configuration.access_token
    end

    def get_access_token(client_id, client_secret, api_key)
      options = {
        client_id: client_id,
        client_secret: client_secret,
        api_key: api_key,
        grant_type: 'password'
      }

      post_form_to_bigtincan_api "/oauth2/token", options
    end

    def refresh_access_token(client_id, client_secret, refresh_token)
      options = {
        client_id: client_id,
        client_secret: client_secret,
        refresh_token: refresh_token,
        grant_type: 'refresh_token'
      }

      post_form_to_bigtincan_api "/oauth2/token", options
    end

  private
    def permitted_options(options)
      options.select { |key, value| PERMITTED_OPTIONS.include? key }
    end
  end
end
