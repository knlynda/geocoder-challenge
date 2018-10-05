module GoogleGeocoder
  class Response
    STATUS_KEY = 'status'.freeze
    ERROR_MESSAGE_KEY = 'error_message'.freeze
    RESULTS_KEY = 'results'.freeze
    LOCATION_PATH = ['results', 0, 'geometry', 'location'].freeze
    LOCATION_ATTRIBUTES = %w[lat lng].freeze

    ERROR_STATUS_MESSAGES = {
      'OVER_DAILY_LIMIT'.freeze => 'Daily query limit is over.',
      'OVER_QUERY_LIMIT'.freeze => 'Query limit is over.',
      'REQUEST_DENIED'.freeze => 'Request denied.',
      'INVALID_REQUEST'.freeze => 'Missing the address parameter.'
    }.tap { |f| f.default = 'Unknown error.' }.freeze

    attr_reader :data

    def initialize(response_json)
      @data = JSON.parse(response_json)
    rescue JSON::ParserError, TypeError
      @data = {}
    end

    def location
      return {} if empty?

      data.dig(*LOCATION_PATH)&.slice(*LOCATION_ATTRIBUTES)
    end

    def error_message
      return if success?

      ERROR_STATUS_MESSAGES[status]
    end

    def status
      data[STATUS_KEY]
    end

    def success?
      !failure?
    end

    def failure?
      data.key?(ERROR_MESSAGE_KEY)
    end

    def empty?
      data[RESULTS_KEY].blank?
    end
  end
end
