module SiteMeta
  VERSION = '0.1'

  def meta_content_type(type=:utf)
    type = "utf-8" if type == :utf
    meta_tag("Content-Type", "text/html;charset=#{type}", "http-equiv")
  end
  
  def head_title(default_title, separator=" - ")
    title = [@head_title, default_title].flatten.compact.join(separator)
    title_tag(title)
  end
  
  def meta_description(default_description=nil)
    description = @meta_description || default_description
    if description
      meta_tag(:description, description)
    end
  end
  
  def split_keywords(keywords)
    return [] unless keywords
    keywords.split(",")
  end
  
  def meta_keywords(default_keywords=nil)
    merge_mode = @meta_keywords_merge_mode || :merge
    meta_keywords = split_keywords(@meta_keywords)
    keywords = if merge_mode == :merge
      default_keywords = split_keywords(default_keywords)
      (meta_keywords + default_keywords).uniq
    else
      meta_keywords
    end
    
    unless keywords.empty?
      meta_tag(:keywords, keywords.join(","))
    end
  end
  
  def meta_tag(name, content, key='name')
    "<meta #{key}=\"#{name}\" content=\"#{content}\" />"
  end
  
  def title_tag(content)
    "<title>#{content}</title>"
  end
  
  def page_title
    @page_title
  end

  def set_head_title(title)
    @head_title = title
  end
  
  def set_head_and_page_title(title)
    title = [title].flatten.compact
    set_head_title title
    set_page_title title.first
  end
  
  def set_page_title(title)
    @page_title = title
  end
  
  def set_meta_description(description)
    @meta_description = description
  end
  
  def set_meta_keywords(keywords, merge_mode=:merge)
    raise(ArgumentError, "Allowed merge modes are only :replace, :merge") unless [:replace,:merge].include?(merge_mode) 
    @meta_keywords = keywords
    @meta_keywords_merge_mode = merge_mode
  end
end