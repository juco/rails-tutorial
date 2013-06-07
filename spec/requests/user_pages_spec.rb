require 'spec_helper'

describe "User pages" do

    subject { page }

    describe "signup page" do
        before { visit signup_path }

        it { should have_selector('h1',    text: 'Sign up') }
        it { should have_selector('title', text: full_title('Sign up')) }
    end

    describe "profile page" do
        let(:user) { FactoryGirl.create(:user) }
        before { visit user_path(user) }

        it { should have_selector('h1', text: user.name) }
        it { should have_selector('title', text: user.name) }
    end

    describe "signup" do

        before { visit signup_path }
        let(:submit) { "Create my account" }

        describe "with invalid data" do
        	it "should not increment the user count with no values" do
        		expect { click_button submit }.not_to change(User, :count)
        	end

            describe "after clicking submit should display errros" do
                before { click_button submit }

                it { should have_selector('title', text: 'Sign up') }
                it { should have_content 'error' }
            end

            describe "for the email address" do
                before do
                    fill_in "Name", with: "Example user"
                    fill_in "Email", with: "foo@invalid" # Invalid email
                    fill_in "Password", with: "foobar"
                    fill_in "Confirmation", with: "foobar"
                end

                it "should display an error regarding the email" do
                    click_button submit
                    page.should have_content "Email is invalid"
                end
            end
        end

        describe "with valid data" do
            before do
                fill_in "Name", with: "Example user"
                fill_in "Email", with: "julian@juco.co.uk"
                fill_in "Password", with: "foobar"
                fill_in "Confirmation", with: "foobar"
            end
            it "should increment the user count" do
                expect { click_button submit }.to change(User, :count).by(1)
            end
        end
    end
end