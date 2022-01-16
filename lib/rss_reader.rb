#!/usr/bin/env ruby

require 'rss'
require 'open-uri'

class Rss_Feed

    attr_reader :url

    def initialize(url)
        @url = url
    end

    def produce_rss
        feed = parse_feed(read_rss_feed)
        extract_items(feed)
    end

    private

    def read_rss_feed
        URI.open @url
    rescue SocketError
        'An issue occured opening the URL'
    end

    def parse_feed(rss_feed)
        RSS::Parser.parse(rss_feed)
    end

    def extract_items(feed)
        puts "\n#{feed.channel.title}"
        feed.items.each do |item|
            print_item(item)
            puts "................................."
        end

    end
    
    def print_item(item)
        puts "\n................................."
        puts "Item_Title: #{item.title}"
        puts "\nItem_Description: #{item.description}"
        puts "\nItem_Link: #{item.link}"
    end

end

puts "Please enter you RSS Feed URL: "

rss_feed = Rss_Feed.new(gets.chomp)

rss_feed.produce_rss

puts rss_feed.url
