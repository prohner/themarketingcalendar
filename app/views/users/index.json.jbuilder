json.array!(@users) do |user|
  json.extract! user, :id, :username, :first_name, :last_name, :email, :password, :company_id
  json.url user_url(user, format: :json)
end
