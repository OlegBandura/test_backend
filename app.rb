require 'sinatra'
require 'sinatra/activerecord'
require_relative 'models/message'
require 'pry'

before do
  content_type 'application/json'
end

post '/message' do
  message = Message.new(
    urlsafe: params['urlsafe'],
    encryption_key: params['encryption_key'],
    text_message: params['text_message'],
    visits_remaining: params['destroy_option'],
    count_times: params['count_times']
  )

  if params['destroy_option'] == 'hour'
    Thread.new do
      sleep params['count_times'].to_i.hour
      message.delete
    end
  end

  if message.save
    halt 201
  else
    halt 422
  end

  redirect to("/message/#{message.urlsafe}")
end

get '/message/:urlsafe' do
  message = Message.where(urlsafe: params['urlsafe']).last
  if message.nil?
    halt 404
  else
    message.update_visit_count
  end

  message.to_json
end
