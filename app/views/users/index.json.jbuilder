json.array!(@users) do |user|
  json.extract! user, :id, :firstname, :lastname, :email, :password, :avatar, :street, :city, :country, :birthday, :birthcity, :birthcountry, :videonumber, :lastcomment, :lastpost, :aboutme, :authorization_token
  json.url user_url(user, format: :json)
end
