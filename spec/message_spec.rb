require_relative 'spec_helper'

describe 'Message' do
  it 'when message visit count = 1' do
    Message.create(
      text_message: 'test',
      urlsafe: 'aabbcc',
      visits_remaining: 'visit',
      encryption_key: 'key',
      count_times: 1
    )
    expect(Message.new.update_visit_count).to be_truthy
  end
end