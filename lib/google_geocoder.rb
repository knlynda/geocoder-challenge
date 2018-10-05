module GoogleGeocoder
  BASE_URL = 'https://maps.googleapis.com/maps/api/geocode/json'.freeze

  class << self
    attr_reader :api_key

    def configure(api_key:)
      @api_key = api_key
    end

    def geocode(address)
      response_json = Net::HTTP.get(build_uri(address))
      ::GoogleGeocoder::Response.new(response_json)
    end

    private

    def build_uri(address)
      URI(BASE_URL).tap do |uri|
        uri.query = URI.encode_www_form(
          address: address,
          key: api_key
        )
      end
    end
  end
end
