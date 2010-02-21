module SearchHelper
  def sort_link(title, sort, params)
    name = params[:name]
    current_sort = params[:sort]
    current_filter = params[:filter]
    reverse = current_sort.match(/_reverse/)
    arrow = reverse ? "↓" : "↑"
    if current_sort.sub(/_reverse/,'') == sort
      title += " #{arrow}"
      sort += "_reverse" if !reverse
    end
    link_to title, search_path(:name => name, :sort => sort, :filter => current_filter), :class => 'filter_link'
  end
end
