# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  provider   :string(255)
#  uid        :string(255)
#  created_at :datetime
#  updated_at :datetime
#  image      :string(255)
#  location   :string(255)
#  nickname   :string(255)
#

class User < ActiveRecord::Base
  rolify
  attr_accessible :provider, :uid, :name, :email
  validates_presence_of :name

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
          user.name = auth['info']['name'] || ""
          user.email = auth['info']['email'] || ""
          user.image = auth['info']['image'].sub("_normal", "")
          user.location = auth["info"]["location"]
          user.nickname = auth["info"]["nickname"]
      end
    end
  end

end
