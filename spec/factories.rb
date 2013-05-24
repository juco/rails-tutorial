FactoryGirl.define do
  factory :user do
    name     "Julian Cohen"
    email    "julian@juco.co.uk"
    password "foobar"
    password_confirmation "foobar"
  end
end
