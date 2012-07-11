require 'spec_helper'

describe SystemLog do
  fixtures :pages
  set_fixture_class :pages => Social::Page

  before do
    @page = pages(:fan_page)
  end

  subject do
    SystemLog.create!({ :resource_type  => "Social::Page", 
                        :resource_id    => 123, 
                        :action         => "logged action", 
                        :exception      => 'exception message', 
                        :hashed_object  => @page })
  end

  it "should create new log record" do
    lambda { subject }.should change { SystemLog.count }.by(1)
  end
end