module BigTinCan
  class Private
    include HTTParty
    include BigTinCan::API

    PERMITTED_OPTIONS = %i{}.freeze

    attr_accessor :access_token, :rate_limit, :rate_limit_remaining
    base_uri 'https://push.bigtincan.com/webapi'

    def initialize(access_token = nil)
      @access_token = access_token || BigTinCan.configuration.access_token
    end

    def get_tenant_details
      get_from_bigtincan_api "/app/all"
    end

  private
    def permitted_options(options)
      options.select { |key, value| PERMITTED_OPTIONS.include? key }
    end
  end
end

