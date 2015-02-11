class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :shouts

  has_many :relationships, foreign_key: "follower_id"
  has_many :following, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship"
  has_many :followers, through: :reverse_relationships, source: :follower

	validates :username, presence: true, uniqueness: true,
	  format: { with: /[a-zA-Z0-9]{4,20}/,
	  message: "must be between 4 and 20 alphanumerics"}

  def follow!(user)
    self.relationships.create!(followed_id: other_user_id)
  end

  def unfollow!(user)
    self.relationships.find_by(followed_id: other_user_id).destroy
  end

  def follows?(user)
    self.relationships.find_by(followed_id: other_user_id)
  end
end
