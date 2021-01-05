class User <ApplicationRecord
    has_secure_password
    has_many :meal_plans
    has_many :meals, through: :meal_plans
    has_many :meal_schedule, through: :meals

    validates :name, :email, presence: true
    validates :email, uniqueness: true

    def self.from_omniauth(auth)
        find_or_create_by(username: auth[:info][:email]) do |user|
          user.password = SecureRandom.hex(15)
    end 
end 
end