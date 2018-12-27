json.set! :code, "400"
json.set! :status, "error"
json.set! :data do
  json.set! :board do
    json.title @params[:title]
  end
end
json.set! :errors do
  json.set! :title do
    json.array! @board.errors.messages[:title]
  end
  json.set! :full_messages do
    json.array! @board.errors.full_messages
  end
end
