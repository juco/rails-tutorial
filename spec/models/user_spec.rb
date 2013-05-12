# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  before do
  	@user = User.new(name: "Example User", email: "user@example.com")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }

  it { should be_valid }

  describe "The username must be specified" do
  	before { @user.name = " " }
  	it { should_not be_valid }
  end

  describe "The email must be specified" do
  	before { @user.email = " " }
  	it { should_not be_valid }
  end
  
end