module Api::ApiHelper
  def get_previous_page_uri(collection)
    if collection.current_page == 1
      nil
    else
      "#{url_for(only_path: false)}?page=#{collection.current_page - 1}"
    end
  end

  def get_next_page_uri(collection)
    if collection.current_page == collection.total_pages
      nil
    else
      "#{url_for(only_path: false)}?page=#{collection.current_page + 1}"
    end
  end
end
