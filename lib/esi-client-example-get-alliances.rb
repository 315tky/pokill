#!/bin/env ruby
require 'swagger_client'

#api_instance = EsiClient::AllianceApi.new
api_instance = SwaggerClient::AllianceApi.new

opts = { 
  datasource: "tranquility", # String | The server name you would like data from
  user_agent: "user_agent_example", # String | Client identifier, takes precedence over headers
  x_user_agent: "x_user_agent_example" # String | Client identifier, takes precedence over User-Agent
}

begin
  #List all alliances
  result = api_instance.get_alliances(opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling AllianceApi->get_alliances: #{e}"
end
