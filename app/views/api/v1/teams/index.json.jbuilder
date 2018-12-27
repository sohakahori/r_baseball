json.set! :teams do
  json.array! @teams
end

json.set! :meta do
  json.set! :page, @teams.current_page
  json.set! :per_page, @teams.total_pages
  json.set! :page_count, @teams.total_pages
  json.set! :total_count, @teams.total_count
  json.set! :link do
    json.set! :self, "#{url_for(only_path: false)}?page=#{@teams.current_page}"
    json.set! :first, "#{url_for(only_path: false)}?page=1"
    json.set! :previous, get_previous_page_uri(@teams)
    json.set! :next, get_next_page_uri(@teams)
    json.set! :last, "#{url_for(only_path: false)}?page=#{@teams.total_pages}"
  end
end







# {
#     "page": 5,
#     "per_page": 20,
#     "page_count": 20,
#     "total_count": 521,
#     "Links": [
#         {"self": "/products?page=5&per_page=20"},
#         {"first": "/products?page=0&per_page=20"},
#         {"previous": "/products?page=4&per_page=20"},
#         {"next": "/products?page=6&per_page=20"},
#         {"last": "/products?page=26&per_page=20"},
#     ]
# }