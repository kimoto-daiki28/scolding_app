module ApplicationHelper
  def page_title(page_title = '')
    base_title = 'NO無駄遣い(仮)'
    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end
end
