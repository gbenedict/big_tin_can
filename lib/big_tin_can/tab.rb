module BigTinCan
  class Tab
    include HTTParty
    include BigTinCan::API

    PERMITTED_OPTIONS = %i{search page limit}.freeze

    attr_accessor :access_token, :rate_limit, :rate_limit_remaining
    base_uri 'https://pubapi.bigtincan.com/v1/tab'

    def initialize(access_token = nil)
      @access_token = access_token || BigTinCan.configuration.access_token
    end

    def all(options = {})
      get_from_bigtincan_api "/all", options
    end

    def create(options = {})
      post_json_to_bigtincan_api "", options
    end

    def add_group(id, channel_id, options = {})
      put_json_to_bigtincan_api "s/#{id}/channels/#{channel_id}/groups", options
    end

    def delete_group(id, channel_id, group_id)
      delete_from_bigtincan_api "s/#{id}/channels/#{channel_id}/groups/#{group_id}"
    end

    def delete(id)
      delete_from_bigtincan_api "/#{id}"
    end

  private
    def permitted_options(options)
      options.select { |key, value| PERMITTED_OPTIONS.include? key }
    end
  end
end
