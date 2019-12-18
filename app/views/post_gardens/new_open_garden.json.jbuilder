json.array!(@open_days) do |open_day|
  json.extract! open_day, :id, :start_time, :end_time
  json.id open_day.id
  json.title "公開日"
  json.start open_day.start_time
  json.end open_day.end_time
end