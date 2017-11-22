#!/usr/bin/ruby

################################################
#             Required libraries               #
################################################

require 'fileutils'
require 'json'
require 'nokogiri'
require 'ox'
require 'time'
require 'pp'
require 'pry'

class Sample < ::Ox::Sax
    attr_accessor :pool

    def initialize(pool_name, elem_name)
        clear

        @pool_name = pool_name
        @elem_name = elem_name
        @purge = ["CONTEXT", "SECURITY_GROUP_RULE", "OS", "USER_TEMPLATE", "PERMISSIONS"]
        @procesing = true
    end

    def clear
        @current = 0
        @levels  = [{}]
        @pool    = Array.new
    end

    def start_element(name)
        if @purge.include? name
            @procesing = false
            return
        end

        return if name == @pool_name || !@procesing

        @value = nil

        @current = @current + 1

        @levels[@current] = Hash.new if @levels[@current].nil?
    end

    def characters(s)
        @value = s
    end

    def end_element(name)
        if @purge.include? name
            @procesing = true
            return
        end
        return if name == @pool_name || !@procesing

        if @levels[@current].empty?
            @levels[@current-1][name] = @value || {}
        else
            if @levels[@current-1][name]
                @levels[@current-1][name] = [@levels[@current-1][name], @levels[@current]].flatten
            else
                @levels[@current-1][name] = @levels[@current]
            end

            @levels[@current] = Hash.new
        end
        if name == @elem_name
            @pool << @levels[0][@elem_name]

            @current   = 0
            @levels[0] = Hash.new
        else
            @current = @current -1
        end
    end

    alias :text :characters
    alias :cdata :characters
end


# Get XML string
#
# xml_str = @client.call(VM_POOL_METHODS[:accounting],
#             filter_flag,
#             options[:start_time],
#             options[:end_time])
xml_str = File.read("out.xml")

t1 = Time.now
handler = Sample.new("HISTORY_RECORDS", "HISTORY")
Ox.sax_parse(handler, StringIO.new(xml_str), :symbolize => false, :convert_special => true)
t2 = Time.now
pp "sax_parse: #{t2-t1}"

t1 = Time.now
handler.pool.to_json
t2 = Time.now
pp "to_json: #{t2-t1}"
