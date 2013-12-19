# == Schema Information
#
# Table name: bolts
#
#  id          :integer          not null, primary key
#  address     :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  routeid     :string(255)
#

class Bolt < ActiveRecord::Base
	belongs_to :user

	attr_accessible :user_id, :address, :routeid, :description, :created_at, :updated_at, :id

	validates :address, uniqueness: true, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "Only letters allowed." }

end
