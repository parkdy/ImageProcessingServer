class Image < ActiveRecord::Base
  has_attached_file :image, storage: :s3,
                            s3_credentials: File.open(File.join(Rails.root, 'config', 's3.yml')),
                            url: ':s3_domain_url',
                            path: '/images/:id_:basename.:extension'
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
