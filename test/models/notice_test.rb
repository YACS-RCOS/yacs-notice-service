require 'test_helper'

class NoticeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "current scope returns correct days" do
    notice = Notice.create(message: "Hello world!", alert_type: "info", start_date: Date.yesterday, end_date: Date.tomorrow) #good
    notice2 = Notice.create(message: "Hello world!", alert_type: "success", start_date: Date.yesterday, end_date: 5.days.from_now) #good
    notice3 = Notice.create(message: "Hello world!", alert_type: "warning", start_date: Date. yesterday, end_date: 3.days.from_now) #good
    notice4 = Notice.create(message: "Hello world!", alert_type: "danger", start_date: 2.days.ago, end_date: Date.tomorrow) #good

    assert_equal(Notice.current,[notice, notice2, notice3, notice4])
  end

  test "reversed dates are invalid" do
    assert_not( Notice.create(message: "Hello world!", alert_type: "info", start_date: 10.days.from_now, end_date: Date.yesterday).valid? )
    assert_not( Notice.create(message: "Hello world!", alert_type: "info", start_date: Date.tomorrow, end_date: Date.yesterday).valid? )
    assert_not( Notice.create(message: "Hello world!", alert_type: "info", start_date:5.days.from_now, end_date: Date.yesterday).valid? )

  end

  test "current scope does not return future dates" do
    notice = Notice.create(message: "Hello world!", alert_type: "info", start_date: Date.tomorrow, end_date: 2.days.from_now)#bad
    notice2 = Notice.create(message: "Hello world!", alert_type: "info", start_date: 4.days.from_now, end_date: 5.days.from_now) #bad

    assert_equal(Notice.current, [])
  end

  test "current scope does not return old notices" do
    notice= Notice.create(message: "Hello world!", alert_type: "info", start_date: 5.days.ago, end_date: Date.yesterday) #bad
    notice = Notice.create(message: "Hello world!", alert_type: "info", start_date: 10.days.ago, end_date: 3.days.ago)

    assert_equal(Notice.current, [])
  end

  test "message and alert type validations" do
    assert_not( Notice.create(message: "", alert_type: "info", start_date: Date.yesterday, end_date: Date.tomorrow).valid? )
    assert_not( Notice.create(message: nil, alert_type: "info", start_date: Date.yesterday, end_date: Date.tomorrow).valid? )
    assert_not( Notice.create(message: "Hello world!", alert_type: "not an alert type", start_date: Date.yesterday, end_date: Date.tomorrow).valid? )
  end
end
