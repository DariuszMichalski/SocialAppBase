require 'spec_helper'

describe Social::MainController do
  fixtures :users
  set_fixture_class :users => Social::User

  let(:fb_page_id) { "148178158318221" } # facebook fan page id
  let(:fb_admin) { false }
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

  describe "/index" do
    context "when there is no fb_session set" do
      subject { get :index }

      before do
        session[:fb] = nil
        subject
      end

      it "should render 'install' view" do
        response.should render_template("install")
      end
    end

    context "when there is a fb_session set" do
      subject { get :index }

      before do
        session[:fb] = fb_session_payload
      end

      context "if there is no page_id parameter in the payload" do
        let(:fb_page_id) { nil }

        it "should render 'install' view" do
          subject
          response.should render_template("install") 
        end
      end

      context "if the page is not registered yet" do
        it "should redirect to new page registration view" do
          subject
          response.should redirect_to(new_social_page_path)
        end
      end

      context "if the page is registered" do
        before do 
          # register the page from payload (page_id parameter)
          Social::Page.create!(:first_name => "J", :last_name => "S", :email => "js@example.com", :page_id => fb_session_payload["page"]["id"], :terms_of_use => true) 
        end

        it "should redirect to page view" do
          subject
          response.should redirect_to(social_page_path(:id => fb_session_payload["page"]["id"]))
        end
      end
    end

    describe "User fan page assignment" do
      # if user accessing a fan page is an admin of this page, and he is signed up (in DB)
      # and fan page has no user assigned then assign a user to this fanpage
      let(:user) { users(:john) }
      let(:fb_admin) { true }
      let(:fb_user_id) { user.facebook_uid }
      let(:fb_page_id) { "1234567890" }

      before do
        session[:fb] = fb_session_payload
        # register the page from payload (page_id parameter)
        @page = Social::Page.create!(:first_name => "J", :last_name => "S", :email => "js@example.com", :page_id => fb_session_payload["page"]["id"], :terms_of_use => true)
      end

      subject { get :index }

      it "should assign the user to the fan page if it has no user assigned" do
        lambda do
          subject
          @page.reload
        end.should change { @page.user_id }.from(nil).to(user.id)
      end
    end
  end # /index

  describe "/blank" do
    it "should render 'blank' template" do
      get :blank
      response.should render_template("blank")
    end
  end # /blank

  describe "/not_compatibile" do
    it "should render 'not_compatibile' template" do
      get :not_compatibile
      response.should render_template("not_compatibile")
    end
  end # /not_compatibile

  describe "/clear_session" do
    before do
      get :clear_session
    end

    it "should clear the session" do
      session[:fb].should be_nil
    end

    it "should redirect to the root path" do
      response.should redirect_to(root_path)
    end
  end # /not_compatibile

end