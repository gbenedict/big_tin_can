module BigTinCan
  class Group
    include HTTParty
    include BigTinCan::API

    PERMITTED_OPTIONS = %i{group_id search include_personal_group page limit body}.freeze

    attr_accessor :access_token, :rate_limit, :rate_limit_remaining
    base_uri 'https://pubapi.bigtincan.com/v1/group'

    def initialize(oauth_access_token = nil)
      @access_token = oauth_access_token || BigTinCan.configuration.access_token
    end

    def all(options = {})
      get_from_bigtincan_api "/all", options
    end

    def create(options = {})
      post_json_to_bigtincan_api "", options
    end

    def add_user(id, option = {})
      put_json_to_bigtincan_api "/#{id}/users", options
    end

  private
    def permitted_options(options)
      options.select { |key, value| PERMITTED_OPTIONS.include? key }
    end
  end
end
