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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bolt do
    address "MyString"
    user_id ""
    description "MyString"
  end
end
