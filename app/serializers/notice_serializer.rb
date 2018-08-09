class NoticeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :message, :alert_type, :start_date, :end_date
end
