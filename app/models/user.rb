# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  email              :string
#  encrypted_password :string           default(""), not null
#  gender             :integer          default("female")
#  last_name          :string
#  name               :string
#  provider           :string           default("email"), not null
#  tokens             :json
#  uid                :string           default(""), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_email             (email) UNIQUE
#  index_users_on_uid_and_provider  (uid,provider) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :targets, dependent: :destroy
  has_one_attached :avatar

  enum gender: { female: 0, male: 1, other: 2 }
end
