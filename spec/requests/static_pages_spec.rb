require 'spec_helper'

describe "Static pages" do

  describe "Home page" do
    before { visit root_path }
    subject { page }

    it { should have_selector('h1', text: 'Sample App') }

    it { should have_selector('title', text: full_title()) }

    it { should_not have_selector('title', text: '| Home') }

    it "Should redirect to the help page when the help link is clicked" do
      click_link "Help"
      page.should have_selector('h1', text: 'Help')
    end

    it "Should redirect to the about page when the about link is clicked" do
      click_link "About"
      page.should have_selector('h1', text: 'About Us')
    end

    it "Should redirect to the contact page when the contact link is clicked" do
      click_link "Contact"
      page.should have_selector('h1', text: 'Contact')
    end

    it "should redirect to the signup page when the signup link is cliked" do
      click_link "Sign up now!"
      page.should have_selector('h1', text: 'Sign up')
    end
  end

  describe "Help page" do
    before { visit help_path }
    subject { page }

    it { should have_selector('h1', text: 'Help') }

    it { should have_selector('title', text: full_title('Help')) }
  end

  describe "About page" do
    before { visit about_path }
    subject { page }

    it  { should have_selector('h1', text: 'About Us') }
    it { should have_selector('title', text: full_title('About Us')) }
  end

  describe "Contact page" do
      before { visit contact_path }
      subject { page }

      it { should have_selector('h1', text: 'Contact') }
      it { should have_selector('title', text: full_title('Contact')) }
  end
  
end
