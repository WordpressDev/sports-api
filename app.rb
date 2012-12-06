require 'json'
require 'rdiscount'
require 'sinatra'
require 'typhoeus'
require 'uri'
require 'yaml'

class Data

  def self.data
    @data ||= YAML::load(File.open('data.yml'))
  end

  def self.sections
    @sections ||= data['sections'].map do |title|
      { :title => title, :identifier => title.downcase.gsub(' ', '-') }
    end
  end

  def self.section(identifier)
    sections.find { |s| s[:identifier] == identifier } || raise(Sinatra::NotFound)
  end

end

class Search

  def self.search(params, page = 1)
    http.get(host + "/articles/page/#{page}.json?" + build_query(params)).body
  end

  def self.build_query(params)
    enforced = { :site => 'http://www.bbc.co.uk/sport/', :limit => 20 }
    params   = params.merge(enforced).delete_if { |k,v| v.nil? }
    params.keys.sort.map { |k| "#{k}=#{URI::encode(params[k].to_s)}" }.join('&')
  end

  def self.host
    'http://juicer.responsivenews.co.uk'
  end

  def self.http
    Typhoeus::Request
  end

end

set :views, '.'

before do
  cache_control :public, max_age: 300
end

error do
  { :error => 'Internal server error' }.to_json
end

not_found do
  { :error => 'Not found' }.to_json
end

get '/ping' do
  { :message => 'pong' }.to_json
end

get '/sections' do
  { :sections => Data.sections }.to_json
end

get '/sections/:identifier' do
  Search.search :section => Data.section(params['identifier'])[:title]
end

get '/search' do
  query = {
    :section          => params.key?('section') ? Data.section(params['section'])[:title] : nil,
    :published_after  => params['published_after'],
    :published_before => params['published_before'],
    :distance         => params['distance'],
    :location         => params['location']
  }
  Search.search(query, params['page'] || 1)
end

set :markdown, :layout_engine => :erb, :layout => :layout

get '/' do
  markdown :README
end
