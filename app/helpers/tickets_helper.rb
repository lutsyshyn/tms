module TicketsHelper
  def status_label(status_name)
    status_name.downcase!

    if status_name.include?("staff")
      label_type = "label-important"
    elsif status_name.include?("complete")
      label_type = "label-success"
    elsif status_name.include?("cancel")
      label_type = "label-inverse"
    elsif status_name.include?("hold")
      label_type = "label-warning"
    else
      label_type = ""
    end

    content_tag(:span, status_name.capitalize, class: "label #{label_type}")
  end
end
