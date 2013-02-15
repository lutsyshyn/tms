module ApplicationHelper
  def generate_menu_links
    menu_html = []
    Menu.all.each do |menu|
      menu_html << content_tag(:li, link_to(menu.name.capitalize, tickets_path(menu: menu.id)), class: ("active" if params[:menu].to_i == menu.id))
    end
    menu_html.join
  end
end
