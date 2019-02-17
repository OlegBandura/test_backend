class Message < ActiveRecord::Base
  enum visits_remaining: { 'hour': 0, 'visit': 1 }

  def update_visit_count
    if visits_remaining == 'visit' && count_times == 1
      destroy
    else
      update(count_times: count_times - 1)
    end
  end
end
