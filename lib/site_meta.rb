require File.join(File.dirname(__FILE__), 'app', 'helpers','site_meta_helper')

ActionController::Base.helper(SiteMetaHelper)
