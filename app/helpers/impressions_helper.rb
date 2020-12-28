module ImpressionsHelper
  def gone_schedule(impression)
    MySchedule.find(impression.my_schedule_id)
  end
end
