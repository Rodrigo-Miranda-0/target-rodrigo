# == Schema Information
#
# Table name: users
#
#  id                   :bigint           not null, primary key
#  confirmation_sent_at :datetime
#  confirmation_token   :string
#  confirmed_at         :datetime
#  email                :string
#  encrypted_password   :string           default(""), not null
#  gender               :integer          default("female")
#  lastname             :string
#  name                 :string
#  provider             :string           default("email"), not null
#  tokens               :json
#  uid                  :string           default(""), not null
#  unconfirmed_email    :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token  (confirmation_token) UNIQUE
#  index_users_on_email               (email) UNIQUE
#  index_users_on_uid_and_provider    (uid,provider) UNIQUE
#
FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 8) }
    gender { User.genders.values.sample }
  end
end
