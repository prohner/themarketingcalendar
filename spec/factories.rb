FactoryGirl.define do
  factory :category_group do |cg|
    cg.description "category group"
  end

  factory :category do |c|
    c.description "category"
    c.association :category_group
  end


  factory :user do
    first_name            "BillFirst"
    last_name             "BillLast"
    email                 "bill@example.com"
    password              "foobar"
    password_confirmation "foobar"
  end
  # factory :user_tom do
  #   first_name            "TomFirst"
  #   last_name             "TomLast"
  #   email                 "tom@example.com"
  #   password              "foobar"
  #   password_confirmation "foobar"
  # end
end