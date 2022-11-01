class ApplicationRecord < ActiveRecord::Base
  include ActiveStorageSupport::SupportForBase64
  primary_abstract_class
end
