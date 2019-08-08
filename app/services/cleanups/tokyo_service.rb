module Cleanups
  class TokyoService
    def run
      api_url = 'https://api.candyhouse.co/public/sesame/'
      sesame_id = ENV["SESAMI_ID"]
      api_key = ENV["API_KEY"]

      uri = URI.parse(api_url + sesame_id)

      http = Net::HTTP.new(uri.host, uri.port).tap do |this|
        this.use_ssl = true
        this.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      req = Net::HTTP::Post.new(uri.request_uri)

      form_data = { command: :lock }
      req['Authorization'] = api_key
      req['Content-Type'] = 'application/json'

      req.body = form_data.to_json
      http.request(req)
    end
  end
end