FactoryGirl.define do
  factory :user do
    first_name            "BillFirst"
    last_name             "BillLast"
    email                 "bill@example.com"
    password              "foobar"
    password_confirmation "foobar"
    user_type             1
  end
  # factory :user_tom do
  #   first_name            "TomFirst"
  #   last_name             "TomLast"
  #   email                 "tom@example.com"
  #   password              "foobar"
  #   password_confirmation "foobar"
  # end
end