module Spectro

  # Interact with the API exchanging specs and functions
  class HTTPClient

    include Singleton

    class << self
      extend Forwardable
      def_delegators :instance, :upload_undefined_specs
    end

    def upload_undefined_specs
      uri = URI.parse('http://' + Spectro::Config.api_hostname + '/api/specs')
      file_path = '.spectro/undefined.yml'

      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri)
      request.body = File.read(file_path)

      http.request(request)
    end

  end

end
