module DataHelper
  def get_user(update=false, role='artist')
    if !$user || update
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      $user = {
            "email" => Faker::Internet.email,
            "firstName" => first_name,
            "lastName" => last_name,
            "fullName" => "#{first_name} #{last_name}",
            "password" => "secret",
            "role" => role
        }
    end
    $user
  end
end

World(DataHelper)