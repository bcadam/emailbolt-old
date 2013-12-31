# == Schema Information
#
# Table name: blogs
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  body       :text
#  image      :string(255)
#  published   :boolean
#  created_at :datetime
#  updated_at :datetime
#

class Blog < ActiveRecord::Base

	attr_accessible :title, :body, :image, :published

end
