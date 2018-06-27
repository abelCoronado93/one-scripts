#!/usr/bin/ruby

ONE_LOCATION=ENV["ONE_LOCATION"]

if !ONE_LOCATION
    RUBY_LIB_LOCATION="/usr/lib/one/ruby"
    VAR_LOCATION = "/var/lib/one"
    LIB_LOCATION = "/usr/lib/one"
    ETC_LOCATION = "/etc/one"
else
    RUBY_LIB_LOCATION=ONE_LOCATION+"/lib/ruby"
    VAR_LOCATION = ONE_LOCATION+"/var"
    LIB_LOCATION = ONE_LOCATION+"/lib"
    ETC_LOCATION = ONE_LOCATION + "/etc"
end

$: << RUBY_LIB_LOCATION
$: << RUBY_LIB_LOCATION+"/cloud" # For the Repository Manager
$: << RUBY_LIB_LOCATION+"/cli" # For the Repository Manager
$: << LIB_LOCATION+'/oneflow/lib'

################################################
#             Required libraries               #
################################################

require 'base64'
require 'csv'
require 'date'
require 'digest/md5'
require 'erb'
require 'fileutils'
require 'json'
require 'nokogiri'
require 'openssl'
require 'ox'
require 'set'
require 'socket'
require 'sqlite3'
require 'tempfile'
require 'time'
require 'uri'
require 'yaml'
require 'pp'
require 'pry'

require 'opennebula'
include OpenNebula

def parse_times(pagination = nil)
    t1 = Time.now
    if !pagination
        rc = @vmpool.get_hash
    else
        rc = @vmpool.get_hash pagination
    end

    t2 = Time.now
    pp "get_hash [DEFAULT_POOL_PAGE_SIZE = #{pagination}]: #{t2-t1} || records: #{rc["VM_POOL"]["VM"].size}"

    t1 = Time.now
    JSON.pretty_generate rc
    t2 = Time.now
    pp "get_json: #{t2-t1}"
end

@client = Client.new
@vmpool = VirtualMachinePool.new(@client, -2)

t1 = Time.now
@vmpool.info_all
t2 = Time.now
pp "get_xml: #{t2-t1}"

#########################################
#             no pagination             #
#########################################

parse_times


#########################################
#                  50                   #
#########################################

parse_times 50

#########################################
#                  100                  #
#########################################

parse_times 100


#########################################
#                  200                  #
#########################################

parse_times 200


#########################################
#                  300                  #
#########################################

parse_times 300


#########################################
#                  500                  #
#########################################

parse_times 500
