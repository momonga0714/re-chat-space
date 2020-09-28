class Group < ApplicationRecord

  has_many :group_users ,foreign_key: :group_id, dependent: :destroy
  has_many :users, through: :group_users
  has_many :messages ,foreign_key: :group_id, dependent: :destroy
  validates :group_name, presence: true, uniqueness: true
end
