json.array!(@accept_requests) do |accept_request|
  json.extract! accept_request, :id, :r_start_datetime, :r_end_datetime
  json.id accept_request.id
  json.title "【#{accept_request.reservation_name}様 予約受付日】"
  json.start accept_request.r_start_datetime
  json.end accept_request.r_end_datetime
  json.url "/reservations/#{accept_request.id}"
end