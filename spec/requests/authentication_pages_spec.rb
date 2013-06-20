require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe "signin page" do

    before { visit signin_path }

    describe "should have a title and header" do
      it { should have_selector('title', text: 'Sign in') }
      it { should have_selector('h1', text: 'Sign in') }
    end

    describe "with invalid data" do
      before do
        fill_in "Email", with: "unknown@email.com"
        fill_in "Password", with: "FakePassword"
      end
      it "should fail with incorrect data" do
        click_button("Sign in")
        page.should have_selector('div.alert.alert-error', text: "password are incorrect")
      end

      describe "error message should vanish when visiting another page" do
        before { click_link "Home" }
         it { should_not have_selector('div.alert.alert-error') }
      end

    end

    describe "with valid data" do
      let(:user) { FactoryGirl.create(:user) }

      before do
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it { should have_selector('title', text: user.name) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
    end

  end
end
