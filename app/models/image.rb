class Image < ActiveRecord::Base
  has_attached_file :image, storage: :s3,
                            s3_credentials: File.open("#{Rails.root}/config/s3.yml")
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
