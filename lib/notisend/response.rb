module Notisend
  Error = Class.new(StandardError)

  class Response
    extend Forwardable

    attr_reader :faraday_response

    def_delegators :faraday_response, :body, :status

    def initialize(faraday_response)
      @faraday_response = faraday_response
    end

    def parsed_body
      raise Error, body unless success?

      JSON.parse(body)
    end

    def success?
      status >= 200 && status < 300
    end
  end
end
