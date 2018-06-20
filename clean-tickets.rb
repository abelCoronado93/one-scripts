#!/usr/bin/ruby

UNSUPPORTED_RUBY = (RUBY_VERSION =~ /^1.8/) != nil

begin
    require 'zendesk_api'
rescue LoadError
    STDERR.puts "Missing zendesk_api gem"
end

client = ZendeskAPI::Client.new do |config|
    config.url = "https://opennebula.zendesk.com/api/v2"

    config.username =

    config.password =

    config.retry = true
end

if client.current_user.nil? || client.current_user.id.nil?
    puts "Zendesk account credentials are incorrect"
    return false
end

zrequests = client.requests({:status => "open,pending"})

zrequests.each { |zrequest|
    zrequest.solved = true
    zrequest.save!
}