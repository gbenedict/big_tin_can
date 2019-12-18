module BigTinCan
  class Channel
    include HTTParty
    include BigTinCan::API

    PERMITTED_OPTIONS = %i{tab_id search page limit channel_id}.freeze

    attr_accessor :access_token, :rate_limit, :rate_limit_remaining
    base_uri 'https://pubapi.bigtincan.com'

    def initialize(access_token = nil)
      @access_token = access_token || BigTinCan.configuration.access_token
    end

    def all(options = {})
      get_from_bigtincan_api "/v1/channel/all", options
    end

    def create(options = {})
      post_json_to_bigtincan_api "/v1.1/channel", options
    end

    def create_personal(option = {})
      post_json_to_bigtincan_api "/v1/channel/personal/add", options
    end

    def delete(id, archive_stories = false)
      delete_from_bigtincan_api "/v1/channel/#{id}?archive_stories=#{archive_stories}"
    end

  private
    def permitted_options(options)
      options.select { |key, value| PERMITTED_OPTIONS.include? key }
    end
  end
end
