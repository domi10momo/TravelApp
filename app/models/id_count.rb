class IdCount < ApplicationRecord
  def initialize(tweet_count)
    @id_number = 0
  end

  def count_up
    @id_number++
  end
end