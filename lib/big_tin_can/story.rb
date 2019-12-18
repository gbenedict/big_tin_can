module BigTinCan
  class Story
    include HTTParty
    include BigTinCan::API

    PERMITTED_OPTIONS = %i{channel_id page limit fields type filters date_filter exclude_internal_files sort_by upload_type files}.freeze

    attr_accessor :access_token, :rate_limit, :rate_limit_remaining
    base_uri 'https://pubapi.bigtincan.com/v1/story'

    def initialize(access_token = nil)
      @access_token = access_token || BigTinCan.configuration.access_token
    end

    def all(options = {})
      get_from_bigtincan_api "/all", options
    end

    def get(id, options = {})
      get_from_bigtincan_api "/get/#{id}", options
    end

    def create(options = {})
      post_json_to_bigtincan_api "/add", options
    end

    def add_tag(id, options = {})
      post_form_to_bigtincan_api "/add/tag/#{id}", options
    end

    def delete(id)
      delete_from_bigtincan_api "/archive/#{id}"
    end

    def comment(id, options = {})
      post_json_to_bigtincan_api "/comment/#{id}", options
    end

    def update(id, options = {})
      put_json_to_bigtincan_api "/edit/#{id}", options
    end

    # DEPRECATED: use /search/stories instead.
    def search(options = {})
      get_from_bigtincan_api "/search", options
    end

    def share(id, options = {})
      post_json_to_bigtincan_api "/share/#{id}", options
    end

    def upload_file(options = {})
      post_form_to_bigtincan_api "/upload/file", options, { 'Content-Type' => 'multipart/form-data' }
    end

    def add_group(id, channel_id, options = {})
      put_json_to_bigtincan_api "/#{id}/channels/#{channel_id}/groups", options
    end

    def delete_group(id, channel_id, group_id)
      delete_from_bigtincan_api "/#{id}/channels/#{channel_id}/groups/#{group_id}"
    end

  private
    def permitted_options(options)
      options.select { |key, value| PERMITTED_OPTIONS.include? key }
    end
  end
end
