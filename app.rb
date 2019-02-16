require 'sinatra'
require 'sinatra/activerecord'
require_relative 'models/message'

before do
  content_type 'application/json'
end

get '/messages' do
  Message.all.to_json
end

post '/message' do
  message = Message.new(
    urlsafe: params['urlsafe'],
    encryption_key: params['encryption_key'],
    text_message: params['text_message'],
    visits_remaining: params['destroy_option']
  )

  # if params['destruction_option'] == 'n_link_visits'
  #   message.visits_remaining = params['destruction_option_value'].to_i + 1
  # else
  #   Thread.new do
  #     sleep params['destruction_option_value'].to_i.hour
  #     message.delete
  #   end
  # end
  if message.save
    halt 201
  else
    halt 422
  end

  redirect to("/message/#{message.urlsafe}")
end

get '/message/:urlsafe' do
  @message = Message.where(urlsafe: params['urlsafe']).last
  if @message.nil?
    halt 404
  else
    if @message.destroyed_via_link_visits?
      @message.visits_remaining -= 1
      @message.save
      if @message.visits_remaining == 0
        @message.delete
      end
    end
  end

  @message.to_json
end
