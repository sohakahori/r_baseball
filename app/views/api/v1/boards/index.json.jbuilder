json.set! :bords do
  json.array! @boards do |board|
    json.id board.id
    json.title board.title
    json.user_id board.user_id
    json.created_at board.created_at
    json.updated_at board.updated_at
    json.set! :user do
      json.id board.user.id
      json.first_name board.user.first_name
      json.last_name board.user.last_name
    end
  end
end

json.set! :meta do
  json.set! :page, @boards.current_page
  json.set! :per_page, @boards.total_pages
  json.set! :page_count, @boards.total_pages
  json.set! :total_count, @boards.total_count
  json.set! :link do
    json.set! :self, "#{url_for(only_path: false)}?page=#{@boards.current_page}"
    json.set! :first, "#{url_for(only_path: false)}?page=1"
    json.set! :previous, get_previous_page_uri(@boards)
    json.set! :next, get_next_page_uri(@boards)
    json.set! :last, "#{url_for(only_path: false)}?page=#{@boards.total_pages}"
  end
end
