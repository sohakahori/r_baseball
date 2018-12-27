json.set! :status, "success"
json.set! :response do
  json.id  @response.id
  json.body @response.body
  json.created_at @response.created_at
  json.updated_at @response.updated_at
  json.board_id @response.board.id
  json.board_title @response.board.title
  json.set! :user do
    json.id  @response.user.id
    json.first_name  @response.user.first_name
    json.last_name  @response.user.last_name
    json.nickname  @response.user.nickname
  end
end

