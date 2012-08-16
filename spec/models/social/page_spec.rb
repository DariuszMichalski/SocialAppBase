require 'spec_helper'

describe Page do

  let(:now) { '2012-01-01'.to_date }

  before(:each) do
    # freeze the time
    Timecop.freeze(now)
  end

  subject do 
    Page.create!({:page_id      => 123356,
                          :first_name   => "John",
                          :last_name    => "Smith",
                          :email        => "john@example.com",
                          :terms_of_use => true }) 
  end

  it "should create a new page" do
    lambda { subject }.should change { Page.count }.by(1)
  end

  it "should have default settings set" do
    subject.settings.all.should == { "end_date" => (now + 2.weeks).strftime("%Y-%m-%d"), "time_limit" => "false" }
  end
end