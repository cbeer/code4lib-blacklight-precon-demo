module ApplicationHelper
  def render_dimension_values data = {}
    h = Hash[data[:value].scan(/\w+:/).zip(data[:value].split(/\w+:/).reject { |x| x.blank? })]
    
    safe_join(h.map do |k,v|
      content_tag :div do
        (content_tag :strong, k) + 
        (content_tag :span, v)
      end
    end, "")
  end
end
