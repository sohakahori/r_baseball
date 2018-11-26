json.set! :code, "400"
json.set! :errors do
  json.array! @board.errors.full_messages
end
