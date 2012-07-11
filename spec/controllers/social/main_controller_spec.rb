require 'spec_helper'

describe Social::MainController do
  
  let(:page_id) { "148178158318221" } # facebook fan page id

  let(:fb_session_payload) do
    { "algorithm"   => "HMAC-SHA256",
      "expires"     => 1341961200,
      "issued_at"   => 1341955635,
      "oauth_token" => "AAADa4DHxvnai3D4Q6qZBKi7rj3upZCvAuspjpBGxhEvH4ZBBpBahkLoOKaPpATimzTaiohPWETShWY69REshSfIR5X79vtBj6SBN",
      "page" => { "id"    => page_id,
                  "liked" => true,
                  "admin" => true },
      "user" => { "country" => "pl",
                  "locale"  => "pl_PL",
                  "age"     => { "min" => 21 }
                },
      "user_id" => "100012037312803"
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
        let(:page_id) { nil }

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
          Social::Page.create!(:first_name => "J", :last_name => "S", :email => "js@example.com", :page_id => page_id, :terms_of_use => true) 
        end

        it "should redirect to page view" do
          subject
          response.should redirect_to(social_page_path(:id=>page_id))
        end
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