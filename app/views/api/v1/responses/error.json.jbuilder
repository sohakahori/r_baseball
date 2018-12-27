json.set! :code, "400"
json.set! :status, "error"
json.set! :data do
  json.set! :response do
    json.body @params[:body]
  end
end
json.set! :errors do
  json.set! :body do
    json.array! @response.errors.messages[:body]
  end
  json.set! :full_messages do
    json.array! @response.errors.full_messages
  end
end
