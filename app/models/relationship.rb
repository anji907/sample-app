class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  # belongs_toにより自動的にバリデーションが追加されるため、以下の記述は省略可能
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
