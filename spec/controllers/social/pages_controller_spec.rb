require 'spec_helper'

describe Social::PagesController do
  fixtures :users
  set_fixture_class :users => Social::User

  let(:fb_page_id) { "148178158318221" } # facebook fan page id
  let(:fb_admin) { true }
  let(:fb_user_id) { "100012037312803" }

  let(:fb_session_payload) do
    { "algorithm"   => "HMAC-SHA256",
      "expires"     => 1341961200,
      "issued_at"   => 1341955635,
      "oauth_token" => "AAADa4DHxvnai3D4Q6qZBKi7rj3upZCvAuspjpBGxhEvH4ZBBpBahkLoOKaPpATimzTaiohPWETShWY69REshSfIR5X79vtBj6SBN",
      "page" => { "id"    => fb_page_id,
                  "liked" => true,
                  "admin" => fb_admin },
      "user" => { "country" => "pl",
                  "locale"  => "pl_PL",
                  "age"     => { "min" => 21 }
                },
      "user_id" => fb_user_id
    }
  end

  describe "standard routes" do
    it "should map { :controller => 'social/pages', :action => 'show', :id => 'ONE' } to '/social/pages/ONE" do
      { :get => '/social/pages/ONE' }.should route_to(:controller => 'social/pages', :action => 'show', :id => "ONE")
    end
  end

  describe "requests" do
    before(:each) do
      # for facebook authentication
      FacebookAuthentication.should_receive(:parse_signed_request).and_return(fb_session_payload)
    end

    describe "/new" do
      # :signed_request parameter added to force setting up a facebook session
      subject { get :new, { :signed_request => true } }

      context "when fb_session is set and user is a fan page admin" do
        it "should initialize a new Page" do
          Social::Page.should_receive(:new)
          subject
        end

        it "should render 'new' template" do
          subject
          response.should render_template(:new)
        end
      end

      context "when fb_session is not set" do
        let(:fb_session_payload) { nil }

        # this happens if the request is not being sent within Facebook platform
        it "should render blank template" do
          Social::Page.should_not_receive(:new)
          subject
          response.should render_template("social/main/blank")
        end
      end
    end

  end # requests
end