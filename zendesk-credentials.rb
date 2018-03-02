#!/usr/bin/ruby

UNSUPPORTED_RUBY = (RUBY_VERSION =~ /^1.8/) != nil

begin
    require 'zendesk_api'
rescue LoadError
    STDERR.puts "Missing zendesk_api gem"
end

client = ZendeskAPI::Client.new do |config|
    # Mandatory:
    config.url = "https://opennebula.zendesk.com/api/v2"

    # Basic / Token Authentication
    config.username = ARGV[0]

    # Choose one of the following depending on your authentication choice
    # config.token = "your zendesk token"
    config.password = ARGV[1]

    # OAuth Authentication
    # config.access_token = "your OAuth access token"

    # Optional:

    # Retry uses middleware to notify the user
    # when hitting the rate limit, sleep automatically,
    # then retry the request.
    config.retry = true

    # Logger prints to STDERR by default, to e.g. print to stdout:
    # require 'logger'
    # config.logger = Logger.new(STDOUT)

    # Changes Faraday adapter
    # config.adapter = :patron

    # When getting the error 'hostname does not match the server certificate'
    # use the API at https://yoursubdomain.zendesk.com/api/v2
end

if client.current_user.nil? || client.current_user.id.nil?
    puts "Zendesk account credentials are incorrect"
else
    puts "Zendesk account credentials are correct"
end