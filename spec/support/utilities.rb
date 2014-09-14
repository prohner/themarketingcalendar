def sign_in(user, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara.
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
    visit root_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end

def puts_user(u)
  puts
  puts u.email
  u.category_groups.each do |cg|
    puts "  #{cg.description}"
    cg.categories.each do |c|
      puts "    #{c.description}"
      c.events.each do |e|
        puts "      #{e.explain})"
      end
    end
  end
end