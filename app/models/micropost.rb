class Micropost < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size

  # default_scope, can be used to set the default order in which elements are retrieved from the database
  # -> is the “stabby lambda” syntax for an object called a Proc (procedure) or lambda,
  # which is an anonymous function (a function created without a name).
  # The stabby lambda -> takes in a block and returns a Proc, which can then be evaluated with the call method

  default_scope -> { order(created_at: :desc) }

  # Using CarrierWave: We need to add the mount_uploader method with the attribute symbol and the uploader class
  mount_uploader :picture, PictureUploader

  # micropost.user	Returns the User object associated with the micropost
  # user.microposts	Returns a collection of the user’s microposts
  # user.microposts.create(arg)	Creates a micropost associated with user
  # user.microposts.create!(arg)	Creates a micropost associated with user (exception on failure)
  # user.microposts.build(arg)	Returns a new Micropost object associated with user
  # user.microposts.find_by(id: 1)	Finds the micropost with id 1 and user_id equal to user.id

  # Validates the size of uploaded picture
  def picture_size
    if picture.size > 2.megabytes
      errors.add(:picture, "should be less than 2MB")
    end
  end

end
