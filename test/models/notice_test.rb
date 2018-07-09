require './test/test_helper'

class NoticeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "current scope returns correct days" do
    notice = Notice.create(start_date: Date.yesterday, end_date: Date.tomorrow) #good
    notice2 = Notice.create(start_date: Date.yesterday, end_date: 5.days.from_now) #good
    notice3 = Notice.create(start_date: Date. yesterday, end_date: 3.days.from_now) #good
    notice4 = Notice.create(start_date: 2.days.ago, end_date: Date.tomorrow) #good

    assert_equal(Notice.current,[notice, notice2, notice3, notice4])
  end

  test "current scope does not return reversed dates" do
    notice = Notice.create(start_date: 10.days.from_now, end_date: Date.yesterday) #bad
    notice1 = Notice.create(start_date: Date.tomorrow, end_date: Date.yesterday) #bad
    notice2 = Notice.create(start_date:5.days.from_now, end_date: Date.yesterday) #bad

    assert_equal(Notice.current, [])
  end

  test "current scope does not return future dates" do
    notice = Notice.create(start_date: Date.tomorrow, end_date: 2.days.from_now)#bad
    notice2 = Notice.create(start_date: 4.days.from_now, end_date: 5.days.from_now) #bad

    assert_equal(Notice.current, [])
  end

  test "current scope does not return old notices" do
    notice= Notice.create(start_date: 5.days.ago, end_date: Date.yesterday) #bad
    notice = Notice.create(start_date: 10.days.ago, end_date: 3.days.ago)

    assert_equal(Notice.current, [])
  end
end
