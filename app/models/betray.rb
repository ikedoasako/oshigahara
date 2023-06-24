class Betray < ApplicationRecord
  
  belongs_to :bushou, dependent: :destroy
  belongs_to :user, dependent: :destroy
  
end
