module ApplicationHelper
  def simple_format(content)
    ERB.new(content).result(binding).html_safe
  end
end
