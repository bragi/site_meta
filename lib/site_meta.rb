# Provides helpers for easily adding metadata to your views and layouts.
#
# In your layout use helpers +head_title+, +meta_description+, +meta_keywords+
# with optional defaults. In each view you can override the defaults using
# helpers +set_head_title+, +set_meta_description+, +set_meta_keywords+.
#
# == Providing description meta
#
# In your layout use +meta_description+ in head section of HTML with optional
# default description:
#
#   %head
#     = meta_description("Site_meta is the easiest way to provide metadata in your Rails application")
#
# In each view you can override default setting using +set_meta_description+.
# In view app/views/pages/show.html.haml
#
#   - set_meta_description(h(@page.description))
#
# == Providing keywords meta
#
# In your layout use +meta_keywords+ in head section of HTML with optional
# list of default keywords:
#
#   %head
#     = meta_keywords("rails,gem,plugin,ruby,meta,metadata,html")
#
# In each view you can override or add keywords using +set_meta_keywords+.
# In view app/views/pages/show.html.haml
#
#   - set_meta_keywords(h(@page.tags.join(",")))
#
# which will add keywords to the default set or
#
#   - set_meta_keywords("pricing,information", :replace)
#
# to replace the whole list.
#
# == Providing title
#
# In your layout use +head_title+ in head section and provide last element of
# breadcrumb trail (usually site name)
#
#   %head
#     = head_title("Site_meta")
#
# In each view you provide title using +set_head_title+, where you can provide
# more elements of breadcrumbs. In view app/views/pages/show.html.haml
#
#   - set_head_title(h(@page.title))
#
# or in app/views/pages/edit.html.haml
#
#   - set_head_title("Editing #{h(@page.title)}", "Pages")
#
# This will result in title set to:
#
#   "Page title - Site_meta"
#
# in first case and:
#
#   "Editing Page title - Pages - Site_meta"
#
# in second case
#
# == Providing title in HTML
#
# Title that is presented in the body part of HTML doesn't need the
# breadcrumbs and may differ from the title presented in HTML head part.
# Use +page_title+ helper in your layout:
#
#   %body
#     %h1= page_title
#
# In each view set the page title using +set_page_title+ helper. In view
# app/views/pages/show.html.haml:
#
#   - set_page_title(h(@page.title))
#
# == Providing head and page title at the same time
#
# In most situations (like in case of show.html.haml mentioned above) you want
# to have the same title used as a page title and as a beginning of the
# breadcrumb trail. In that case use +set_head_and_page_title+ helper.
# In view app/views/pages/show.html.haml
#
#   - set_head_and_page_title(h(@page.title), "Pages")
#
# This will set page title to first element and set proper trail in head.
#
# == Providing encoding
#
# To provide encoding information use +meta_content_type+ in your layout use
#
#   %head
#     = meta_content_type
#
# This will provide utf-8 charset by default.
module SiteMeta
  VERSION = '0.2.0'

  # Returns meta tag with appropriate encoding specified. +type+ may be any
  # string, it's inserted verbatim. Popular encodings include "utf-8",
  # "iso-8859-1" and others.
  def meta_content_type(type=:utf)
    type = "utf-8" if type == :utf
    meta_tag("Content-Type", "text/html; charset=#{type}", "http-equiv")
  end

  # Returns string with title tag to use in html head. It uses +default_title+
  # unless you provide breadcrumb elements using +set_head_title+ or
  # +set_head_and_page_title+. Elements of title (with +default_title+
  # being the last one) are joined using +separator+.
  def head_title(default_title, separator=" - ")
    title = [@head_title, default_title].flatten.compact.join(separator)
    title_tag(title)
  end

  # Returns description meta tag with +default_description+ to use in html
  # head. You can override it on per-view base using +set_meta_description+.
  # Returns nil when +default_description+ is nil and you did not provide one
  # using +set_meta_description+.
  def meta_description(default_description=nil)
    description = @meta_description || default_description
    if description
      meta_tag(:description, description)
    end
  end

  # Returns keywords meta tag with +default_keywords+ to use in html head.
  # You can override keywords on per-view base using +set_meta_keywords+.
  # Optional +default_keywords+ may be a comma separated string or array of
  # strings. Returns nil when +default_keywords+ is nil and none additional
  # keywords were provided through +set_meta_keywords+.
  def meta_keywords(default_keywords=[])
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

  # Returns page title set using +set_page_title+
  def page_title
    @page_title
  end

  # Sets head title breadcrumbs trail
  def set_head_title(*title)
    @head_title = title.flatten
  end

  # Sets head title breadcrumbs trail and page title to the leftmost element.
  def set_head_and_page_title(*title)
    title = [title].flatten.compact
    set_head_title title
    set_page_title title.first
  end

  # Sets page title to use with +page_title+
  def set_page_title(title)
    @page_title = title
  end

  # Sets meta +description+ to use with +meta_description+.
  def set_meta_description(description)
    @meta_description = description
  end

  # Sets +keywords+ to use with +meta_keywords+. Optional +merge_mode+ may be
  # set to either :merge (default) or :replace. In the second mode provided
  # keywords are not merged with defaults when output using +meta_keywords+.
  def set_meta_keywords(keywords, merge_mode=:merge)
    raise(ArgumentError, "Allowed merge modes are only :replace, :merge") unless [:replace,:merge].include?(merge_mode)
    @meta_keywords = keywords
    @meta_keywords_merge_mode = merge_mode
  end

  def split_keywords(keywords) #:nodoc:
    return [] unless keywords
    keywords = keywords.split(",") if keywords.is_a? String
    keywords.flatten.map {|k| k.strip}
  end

  def meta_tag(name, content, key='name') #:nodoc:
    if respond_to?(:tag)
      tag 'meta', key => name, :content => content
    else
      "<meta #{key}=\"#{name}\" content=\"#{content}\" />"
    end
  end

  def title_tag(content) #:nodoc:
    if respond_to?(:content_tag)
      content_tag "title", content
    else
      "<title>#{content}</title>"
    end
  end

end