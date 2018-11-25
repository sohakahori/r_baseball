json.set! :players do
  json.array! @players
end

json.set! :meta do
  json.set! :page, @players.current_page
  json.set! :per_page, @players.total_pages
  json.set! :page_count, @players.total_pages
  json.set! :total_count, @players.total_count
  json.set! :link do
    json.set! :self, "#{url_for(only_path: false)}?page=#{@players.current_page}"
    json.set! :first, "#{url_for(only_path: false)}?page=1"
    json.set! :previous, get_previous_page_uri(@players)
    json.set! :next, get_next_page_uri(@players)
    json.set! :last, "#{url_for(only_path: false)}?page=#{@players.total_pages}"
  end
end
