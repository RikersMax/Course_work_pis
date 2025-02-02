module ApplicationHelper
  def render_navbar
    render(partial: 'shared/navbar')
  end

  def title_page(name_page)
    title_name = 'PIS'

    if name_page.present? then
      title_name = title_name + "|" + name_page 
    end

    return title_name
  end

end
