module DataHelper
  def get_user
    $user ||= (
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name

      {
          "email" => Faker::Internet.email,
          "firstName" => first_name,
          "lastName" => last_name,
          "fullName" => "#{first_name} #{last_name}",
          "password" => "secret"
      }
    )
  end
end

World(DataHelper)