class User < ActiveRecord::Base
  include BCrypt
  validates :email, uniqueness: true, presence: true
  validates :email, format: { with: /\w+@\w+\.\w+/, message: "Email is not valid"}
  validates :password, presence: true

  has_many :event_attendances
  has_many :attended_events, through: :event_attendances, source: :event
  has_many :created_events, foreign_key: 'user_id', class_name: 'Event'

  def password
      @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end

  def self.create(params)
    @user = User.new(email: params[:email])
    @user.password = params[:password]
    @user.save
    @user
  end

  def self.authenticate(params)
    @user = User.find_by_email(params[:email])
    if @user.password == params[:password]
      @user
    else
      nil
    end
  end

end
