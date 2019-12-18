module BigTinCan
  module API
    def get_response(url, options)
      self.class.get(url, options)
    end

    def post_response(url, options)
      self.class.post(url, options)
    end

    def put_response(url, options)
      self.class.put(url, options)
    end

    def delete_response(url, options)
      self.class.delete(url, options)
    end

    def parse_json(response)
      JSON.parse(response.body, symbolize_names: BigTinCan.configuration.symbolize_keys)
    end

  private

    def get_from_bigtincan_api(url, options = {})
      headers = {
        'Authorization' => "Bearer #{@access_token}",
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }

      response = get_response(url, {
        query: permitted_options(options),
        headers: headers
      })

      parse_response(response, true)
    end

    def post_json_to_bigtincan_api(url, body, headers = nil)
      headers ||= {}
      headers = {
        'Authorization' => "Bearer #{@access_token}",
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }.merge(headers)

      response = post_response(url, {
        body: JSON.dump(body),
        headers: headers
      })

      parse_response(response, true)
    end

    def post_form_to_bigtincan_api(url, body, headers = nil)
      headers ||= {}
      default_headers = {
        'Content-Type' => 'application/x-www-form-urlencoded'
      }
      default_headers['Authorization'] = "Bearer #{@access_token}" if @access_token.present?

      headers = default_headers.merge(headers)

      response = post_response(url, {
        body: body,
        headers: headers#, debug_output: $stdout
      })

      parse_response(response, true)
    end

    def put_json_to_bigtincan_api(url, body, headers = nil)
      headers ||= {}
      headers = {
        'Authorization' => "Bearer #{@access_token}",
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }.merge(headers)

      response = put_response(url, {
        body: JSON.dump(body),
        headers: headers
      })

      parse_response(response)
    end

    def delete_from_bigtincan_api(url, headers = nil)
      headers ||= {}
      headers = {
        'Authorization' => "Bearer #{@access_token}",
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }.merge(headers)

      response = delete_response(url, {
        headers: headers
      })

      parse_response(response)
    end

    def parse_response(response, set_response_headers = false)
      set_response_headers_info(response.headers) if set_response_headers

      body = parse_json(response)
      if [200, 201, 204].include? response.code
        body
      elsif response.code == 404
        puts response
        raise BigTinCan::NotFound.new("Not Found")
      elsif body.try(:[], :error).try(:is_a?, Hash)
        puts response
        raise BigTinCan::Error.new(body[:error][:message], response.code)
      elsif body.try(:is_a?, Hash)
        puts response
        raise BigTinCan::Error.new("#{body[:error]} - #{body[:error_description]}", response.code)
      else
        puts response
        raise BigTinCan::Error.new("Error parsing response", response.code)
      end
    end

    def set_response_headers_info(headers)
      self.rate_limit = headers['x-ratelimit-limit'].to_i
      self.rate_limit_remaining = headers['x-ratelimit-remaining'].to_i
    end
  end
end
