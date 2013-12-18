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
#

class Bolt < ActiveRecord::Base
	belongs_to :user
	attr_accessible :user_id, :address, :description, :created_at, :updated_at, :id

	validates :address, uniqueness: true


end
