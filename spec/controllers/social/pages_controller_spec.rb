require 'spec_helper'

describe Social::PagesController do

  describe "standard routes" do
    it "should map { :controller => 'social/pages', :action => 'show', :id => 'ONE' } to '/social/pages/ONE" do
      { :get => '/social/pages/ONE' }.should route_to(:controller => 'social/pages', :action => 'show', :id => "ONE")
    end
  end

end