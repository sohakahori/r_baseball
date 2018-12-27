json.set! :responses do
  json.array! @responses do |response|
    json.id response.id
    json.body response.body
    json.created_at response.created_at
    json.updated_at response.updated_at
    json.board_id response.board.id
    json.board_title response.board.title
    json.set! :user do
      json.id response.user.id
      json.first_name response.user.first_name
      json.last_name response.user.last_name
      json.nickname response.user.nickname
    end
  end
end

json.set! :meta do
  json.set! :page, @responses.current_page
  json.set! :per_page, @responses.total_pages
  json.set! :page_count, @responses.total_pages
  json.set! :total_count, @responses.total_count
  json.set! :link do
    json.set! :self, "#{url_for(only_path: false)}?page=#{@responses.current_page}"
    json.set! :first, "#{url_for(only_path: false)}?page=1"
    json.set! :previous, get_previous_page_uri(@responses)
    json.set! :next, get_next_page_uri(@responses)
    json.set! :last, "#{url_for(only_path: false)}?page=#{@responses.total_pages}"
  end
end
