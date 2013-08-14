require 'net/http'
require 'net/https'
require 'uri'
require 'xmlsimple'
require 'cgi'
require 'singleton'
require 'active_support'

module OpsourceClient
  class Client

    API_ENDPOINT = "https://api.opsourcecloud.net/oec/0.9/"
    
    attr_accessor :api_endpoint, :organization_id, :admin_username, :admin_password

    def initialize
      self.api_endpoint = API_ENDPOINT
      self.organization_id = '123456'
      self.admin_username    = 'USER'
      self.admin_password    = 'PWD'
    end

    def api_base_url
      "#{api_endpoint}/#{@org_id}"
    end

    protected

    def request(type, endpoint, body = nil)
      begin
        uri = URI.parse(api_base_url + endpoint)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        # construct the call data and access token
        req = Net::HTTP.const_get(type.to_s.camelize).new(uri.request_uri, initheader = {'Content-Type' =>'application/json', 'User-Agent' => 'WePay Ruby SDK'})
        req.content_type = "text/xml" if body
        req.body = body if body
        req.basic_auth @username, @password
        response = http.request(req)

      rescue TimeoutError => error
        raise OpsourceClient::Exceptions::ConnectionError.new("Timeout error. Invalid Api URL or Opsource server is probably down: \"#{@url}\"")
      rescue  SocketError, Errno::ECONNREFUSED => se
        raise OpsourceClient::Exceptions::ConnectionError.new("Socket error. Could not connect to Opsource server.")
      end
      
      response
    end

    def post(endpoint, request_xml = nil)
      res = request(:post, endpoint, request_xml)
      handle_response res
    end

    def get(endpoint, request_xml = nil)
      res = request(:get, endpoint, request_xml)
      handle_response res
    end

    def handle_response(response)
      begin
        h = symbolize_response(response.body)
      rescue OpsourceClient::Exceptions::RequestError => e
        raise OpsourceClient::Exceptions::ApiError.new("Received an Invalid Response. This might mean you sent an invalid request or Opsource is having issues.")
      rescue => e
        raise OpsourceClient::Exceptions::ApiError.new("There was an error while trying to connect to Opsource - #{e.inspect}")
      end
      h
    end

    def symbolize_response(response)
      begin
        # we'll not use 'KeyToSymbol' because it doesn't symbolize the keys for node attributes
        opts = { 'ForceArray' => false, 'ForceContent' => false } #
        hash = XmlSimple.xml_in(response, opts)
        hash.delete_if {|k, v| k =~ /(xmlns|xmlns:ns)/ } #removing the namespaces from response
        return symbolize_keys(hash)
      rescue Exception => e
        raise OpsourceClient::Exceptions::RequestError.new("Impossible to convert XML to hash. Error: #{e.message}")
      end
    end

    def symbolize_keys(arg)
      case arg
      when Array
        arg.map {  |elem| symbolize_keys elem }
      when Hash
        Hash[
          arg.map {  |key, value|
            k = key.is_a?(String) ? key.to_sym : key
            v = symbolize_keys value
            [k,v]
          }]
      else
        arg
      end
    end

    def xml_header
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
    end

  end
end
