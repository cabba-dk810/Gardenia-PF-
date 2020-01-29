# frozen_string_literal: true

json.array!(@visit_requests) do |visit_request|
  json.extract! visit_request, :id, :r_start_datetime, :r_end_datetime
  json.id visit_request.id
  json.title "【#{visit_request.owner_name}様宅 訪問日】#{visit_request.reservation_address}"
  json.start visit_request.r_start_datetime
  json.end visit_request.r_end_datetime
  json.url "/reservations/#{visit_request.id}"
end
