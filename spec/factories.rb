FactoryGirl.define do
  factory :category_group_skeleton, class: CategoryGroup do |cg|
    cg.sequence(:description) { |n| "cat grp #{n}" }
    
    factory :category_group do 
      after(:create) do |cg|
        FactoryGirl.create(:category, category_group: cg)
      end
    end
  end

  factory :category_skeleton, class: Category do |c|
    c.sequence(:description) { |n| "category #{n}" }
    c.association :category_group

    factory :category do 
      after(:create) do |c|
        FactoryGirl.create(:event, category: c)
        FactoryGirl.create(:event, category: c)
        FactoryGirl.create(:event, category: c)
        FactoryGirl.create(:event, category: c, starts_at: "2014-02-01", ends_at: "2014-02-28")
        FactoryGirl.create(:event, category: c, starts_at: "2014-02-15", ends_at: "2014-02-28")
      end
    end
  end

  factory :event, class: Event do |e|
    e.sequence(:description) { |n| "event #{n}" }
    e.starts_at           "2014-01-01"
    e.ends_at             "2014-01-31"
  end

  factory :color_scheme do |cs|
    cs.name               "color scheme"
    cs.foreground         "x"
    cs.background         "y"
  end

  factory :user do
    first_name            "BillFirst"
    last_name             "BillLast"
    email                 "bill@example.com"
    password              "foobar"
    password_confirmation "foobar"
  end

  factory :user_bill_skeleton, class: User do |u|
    u.first_name            "BillFirst"
    u.last_name             "BillLast"
    u.sequence(:email)      { |n| "bill#{n}@example.com" }
    u.password              "foobar"
    u.password_confirmation "foobar"

    factory :user_bill do
      after(:create) do |user|
        FactoryGirl.create(:category_group, user: user)
        FactoryGirl.create(:category_group, user: user)
      end
    end
  end
  

  factory :user_dave_skeleton, class: User do |u|
    u.first_name            "DaveFirst"
    u.last_name             "DaveLast"
    u.sequence(:email)      { |n| "dave#{n}@example.com" }
    u.password              "foobar"
    u.password_confirmation "foobar"

    factory :user_dave do
      after(:create) do |user|
        FactoryGirl.create(:category_group, user: user)
        FactoryGirl.create(:category_group, user: user)
      end
    end
  end
  
end