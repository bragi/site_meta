require File.dirname(__FILE__) + '/spec_helper.rb'

class SiteMetaInstance
  include ActionView::Helpers::TagHelper
  include SiteMetaHelper
end

class NilClass
  def blank?
    true
  end
end

describe SiteMetaHelper do
  before(:each) do
    @helper = SiteMetaInstance.new
  end
  
  it "should use given name and content for meta tag" do
    @helper.meta_tag(:description, "Default").should == '<meta content="Default" name="description" />'
  end
  
  it "should use provided content for title tag" do
    @helper.title_tag("Content").should == "<title>Content</title>"
  end
  
  describe "when providing description" do
    it "should accept empty default description" do
      @helper.meta_description
    end
    
    it "should not insert empty description meta tag" do
      @helper.meta_description.should be_blank
    end
    
    it "should use default description" do
      @helper.meta_description("Default").should == @helper.meta_tag(:description, "Default")
    end
    
    it "should use provided description" do
      @helper.set_meta_description("Non-default")
      @helper.meta_description("Default").should == @helper.meta_tag(:description, "Non-default")
    end
  end

  describe "when providing keywords" do
    it "should accept empty default keywords" do
      @helper.meta_keywords
    end
    
    it "should not insert empty keywords meta tag" do
      @helper.meta_keywords.should be_blank
    end
    
    it "should use default keywords" do
      @helper.meta_keywords("default,keywords").should == @helper.meta_tag(:keywords, "default,keywords")
    end
    
    it "should use default when provided as array" do
      @helper.meta_keywords(["default", "keywords"]).should == @helper.meta_tag(:keywords, "default,keywords")
    end

    it "should strip keywords" do
      @helper.meta_keywords("default , keywords").should == @helper.meta_tag(:keywords, "default,keywords")
    end

    it "should merge provided keywords by default" do
      @helper.set_meta_keywords("non,default")
      @helper.meta_keywords("default,keywords").should == @helper.meta_tag(:keywords, "non,default,keywords")
    end

    it "should set keywords as array" do
      @helper.set_meta_keywords(["non", "default"])
      @helper.meta_keywords("default,keywords").should == @helper.meta_tag(:keywords, "non,default,keywords")
    end

    it "should strip set keywords" do
      @helper.set_meta_keywords(["non ", " default"])
      @helper.meta_keywords("default,keywords").should == @helper.meta_tag(:keywords, "non,default,keywords")
    end

    it "should merge provided keywords" do
      @helper.set_meta_keywords("non,default", :merge)
      @helper.meta_keywords("default,keywords").should == @helper.meta_tag(:keywords, "non,default,keywords")
    end

    it "should replace provided keywords" do
      @helper.set_meta_keywords("non,default", :replace)
      @helper.meta_keywords("default,keywords").should == @helper.meta_tag(:keywords, "non,default")
    end

    it "should reject unknown merge mode" do
      lambda {
        @helper.set_meta_keywords("non,default", :overwrite)
      }.should raise_error(ArgumentError, "Allowed merge modes are only :replace, :merge")
    end
  end
  
  describe "when providing head title" do
    it "should provide default title" do
      @helper.head_title("Site name").should == @helper.title_tag("Site name")
    end
    
    it "should accept string as title" do
      @helper.set_head_title("Page title")
      @helper.head_title("Site name").should == @helper.title_tag("Page title - Site name")
    end
    
    it "should accept array as title" do
      @helper.set_head_title(["Page title"])
      @helper.head_title("Site name").should == @helper.title_tag("Page title - Site name")
    end
    
    it "should accept multiple entries as title" do
      @helper.set_head_title(["Item title", "View title"])
      @helper.head_title("Site name").should == @helper.title_tag("Item title - View title - Site name")
    end

    it "should accept multiple entries as title without array" do
      @helper.set_head_title("Item title", "View title")
      @helper.head_title("Site name").should == @helper.title_tag("Item title - View title - Site name")
    end

    it "should use custom separator" do
      @helper.set_head_title("Page title")
      @helper.head_title("Site name", " &raquo; ").should == @helper.title_tag("Page title &raquo; Site name")
    end
  end
  
  describe "when providing page title" do
    it "should use given title" do
      @helper.set_page_title("Page title")
      @helper.page_title.should == "Page title"
    end
  end
  
  describe "when providing page and head title" do
    it "should accept string title" do
      @helper.set_head_and_page_title("Page title")
      @helper.page_title.should == "Page title"
      @helper.head_title("Site name").should == @helper.title_tag("Page title - Site name")
    end
    
    it "should accept array title" do
      @helper.set_head_and_page_title(["Item title", "View title"])
      @helper.page_title.should == "Item title"
      @helper.head_title("Site name").should == @helper.title_tag("Item title - View title - Site name")
    end
    
    it "should accept multiple elements title" do
      @helper.set_head_and_page_title("Item title", "View title")
      @helper.page_title.should == "Item title"
      @helper.head_title("Site name").should == @helper.title_tag("Item title - View title - Site name")
    end
  end
end
