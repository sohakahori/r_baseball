json.set! :status, "401"
json.set! :errors do
  json.array! @board.errors.full_messages
end
