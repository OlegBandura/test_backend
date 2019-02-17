class Message < ActiveRecord::Base
  enum visits_remaining: { 'hour': 0, 'visit': 1 }

  def destroyed_after_time?
    visits_remaining.nil?
  end

  def time_remaining
    if destroyed_after_time?
      seconds = 1.hour - (Time.now - created_at)
      Time.at(seconds).strftime('%H:%M:%S')
    end
  end

  def update_visit_count
    if visits_remaining == 'visit' && count_times == 1
      destroy
    else
      update(count_times: count_times - 1)
    end
  end
end
