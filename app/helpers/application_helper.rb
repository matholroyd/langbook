module ApplicationHelper
  def heading(title, options = {}, &block)
    back = {:title => '', :path => '', :klass => 'main'}.ostructify
    forward = {:title => '', :path => '', :klass => 'main'}.ostructify
    yield(back, forward) if block
    
    maxChars = 20
    
    content_for :heading, truncate(h(title), :length => 20)
    content_for_heading(:back, back) { |title|  truncate(h(title), :length => maxChars) }
    content_for_heading(:forward, forward) { |title|  truncate(h(title), :length => maxChars) }
  end
  
  def content_for_heading(name, item)
    content_for name, link_to(yield(item.title), item.path, :class => item.klass) unless item.title.blank? || item.path.blank?
  end
  
  
end
