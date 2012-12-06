ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'
require_relative 'app'

class Test < MiniTest::Unit::TestCase

  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_ping
    get '/ping'
    assert last_response.ok?
    assert_equal '{"message":"pong"}', last_response.body
  end

  def test_sections
    get '/sections'
    assert last_response.ok?
    assert_equal ({ :sections => Data.sections }.to_json), last_response.body
  end

  def test_section
    Search.stub :search, 'some-json' do
      get '/sections/archery'
      assert last_response.ok?
      assert 'some-json', last_response.body
    end
  end

  def test_section_must_exist
    get '/sections/foobar'
    assert last_response.not_found?
  end

end
