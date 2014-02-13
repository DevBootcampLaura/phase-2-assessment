class Event < ActiveRecord::Base
  has_many :event_attendances
  has_many :users, through: :event_attendances
  belongs_to :user
end
