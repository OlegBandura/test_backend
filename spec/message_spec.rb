require_relative 'spec_helper'
require 'pry'
describe 'Message' do

  before do
    DatabaseCleaner.clean
  end

  let!(:message) do
    Message.create(
      text_message: 'test',
      urlsafe: 'aabbcc',
      visits_remaining: 'visit',
      encryption_key: 'key',
      count_times: 1
    )
  end

  it 'when message visit count = 1' do

    message.update_visit_count
    expect(Message.count).to eq 0
  end

  it 'when message visit count = 2' do
    message.update(count_times: 2)
    message.update_visit_count
    expect(Message.count).to eq 1
  end
end