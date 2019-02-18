require_relative 'spec_helper'
require 'rack/test'

describe 'app' do
  include Rack::Test::Methods

  def app
    App.new
  end

  before do
    DatabaseCleaner.clean
  end

  describe '#show' do
    context 'get message when 1 visit' do
      let!(:message) do
        Message.create(
          text_message: 'test',
          urlsafe: 'aabbcc',
          visits_remaining: 'visit',
          encryption_key: 'key',
          count_times: 1
        )
      end

      it 'get message' do
        get "/message/#{message.urlsafe}"
        expect(JSON.parse(last_response.body)['id']).to eq message.id
        expect(JSON.parse(last_response.body)['text_message']).to eq message.text_message
        expect(JSON.parse(last_response.body)['urlsafe']).to eq message.urlsafe
        expect(JSON.parse(last_response.body)['visits_remaining']).to eq message.visits_remaining
        expect(JSON.parse(last_response.body)['encryption_key']).to eq message.encryption_key
        expect(JSON.parse(last_response.body)['count_times']).to eq message.count_times
        expect(Message.count).to eq 0
      end
    end
  end

  describe '#create' do
    it 'create new message' do
      post '/message', params={
        text_message: 'test',
        urlsafe: 'aabbcc',
        visits_remaining: 'visit',
        encryption_key: 'key',
        count_times: 1
      }
      expect(last_response.status).to eq 201
      expect(Message.count).to eq 1
    end
  end
end