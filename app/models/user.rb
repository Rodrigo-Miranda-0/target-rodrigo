# frozen_string_literal: true

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
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :targets, dependent: :destroy

  enum gender: { female: 0, male: 1, other: 2 }
end
