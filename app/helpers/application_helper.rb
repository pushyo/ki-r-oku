module ApplicationHelper
  # Return a title on a per-page basis
  def title
    base_title = "Kiroku"
    return base_title + " | " + @title unless @title.nil?
    base_title
  end

  def signed_in?
    !current_user.nil?
  end
end
