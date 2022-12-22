# == Schema Information
#
# Table name: abouts
#
#  id         :bigint           not null, primary key
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class About < ApplicationRecord
end
