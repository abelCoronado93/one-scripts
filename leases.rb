#!/usr/bin/ruby

ONE_LOCATION = ENV["ONE_LOCATION"]

if !ONE_LOCATION
    RUBY_LIB_LOCATION = "/usr/lib/one/ruby"
    VAR_LOCATION      = "/var/lib/one"
    LIB_LOCATION      = "/usr/lib/one"
    ETC_LOCATION      = "/etc/one"
else
    RUBY_LIB_LOCATION = ONE_LOCATION + "/lib/ruby"
    VAR_LOCATION      = ONE_LOCATION + "/var"
    LIB_LOCATION      = ONE_LOCATION + "/lib"
    ETC_LOCATION      = ONE_LOCATION + "/etc"
end

$: << RUBY_LIB_LOCATION
$: << RUBY_LIB_LOCATION + "/cloud" # For the Repository Manager
$: << RUBY_LIB_LOCATION + "/cli" # For the Repository Manager
$: << LIB_LOCATION + '/oneflow/lib'

require 'opennebula'
include OpenNebula

def lease_process(lease_hash)
    if lease_hash.kind_of?(Array)
        lease_hash.each do |lease|
            if lease["VM"]
                @vm_ids.push lease["VM"]
            end
        end
    elsif lease_hash.nil?
        return
    else
        if lease_hash["VM"]
            @vm_ids.push lease_hash["VM"]
        end
    end
end

client = Client.new
obj = OpenNebula::VirtualNetwork.new_with_id(ARGV[0], client)
obj.info

hash = obj.to_hash

@vm_ids = []

ar_hash = hash["VNET"]["AR_POOL"]["AR"]

if ar_hash.kind_of?(Array)
    ar_hash.each do |ar|
        lease_process ar["LEASES"]["LEASE"]
    end
else
    lease_process ar_hash["LEASES"]["LEASE"]
end

puts "VNET #{obj.id}: #{obj.name}"
puts

@vm_ids.each do |id|
    obj = OpenNebula::VirtualMachine.new_with_id(id, client)
    obj.info
    puts "VM #{id}: #{obj.name}"
end
