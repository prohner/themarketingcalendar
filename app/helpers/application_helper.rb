module ApplicationHelper
  def application_name
    "The Marketing Calendar"
  end
  
  def color_scheme_as_html_snippet_to_display(color_scheme)
    "<span style=\"background-color:#{color_scheme.background};color:#{color_scheme.foreground};\">X</span>".html_safe
  end
end
