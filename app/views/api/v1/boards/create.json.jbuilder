json.set! :status, "success"
json.board do
  json.extract! @board, :id, :title, :user_id, :created_at, :updated_at
  json.set! :user do
    json.id @board.user.id
    json.first_name @board.user.first_name
    json.last_name @board.user.last_name
  end
end

