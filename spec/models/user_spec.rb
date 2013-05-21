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
  	@user = User.new(
      name: "Example User", email: "user@example.com",
      password: "foobar", password_confirmation: "foobar"
    )
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "The username must be specified" do
  	before { @user.name = " " }
  	it { should_not be_valid }
  end

  describe "The email must be specified" do
  	before { @user.email = " " }
  	it { should_not be_valid }
  end

  describe "When a name is too long" do
    before { @user.email = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  describe "When an email address is already taken" do
    before do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      duplicate_user.save
    end

    it { should_not be_valid }
  end

  describe "When the password is too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }

  end

  describe "When the password is blank" do
    it "should not be valid" do
      @user.password = " "
      @user.password_confirmation = " "
      @user.should_not be_valid
    end
  end

  describe "When the passwords are missmatched" do
    it "should not be valid" do
      @user.password_confirmation = "missmatch"
      @user.should_not be_valid
    end
  end

  describe "When the password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "Return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_with_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_with_invalid_password }
      specify { user_with_invalid_password.should be_false }
    end
  end

end