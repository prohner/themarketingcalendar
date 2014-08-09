module ApplicationHelper
  def application_name
    "The Marketing Calendar"
  end

  def show_marketing_messages?
    not signed_in?
  end
  
  def color_scheme_as_html_snippet_to_display(color_scheme)
    if color_scheme.nil?
      ""
    else
      "<span style=\"background-color:#{color_scheme.background};color:#{color_scheme.foreground};\" data-toggle=\"tooltip\" title=\"#{color_scheme.name}\">&#9733;</span>".html_safe
    end
  end
  
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end  
  
  ## Devise methods
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
end
