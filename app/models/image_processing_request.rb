class ImageProcessingRequest < ActiveRecord::Base
  belongs_to :original_image, class_name: 'Image'
  belongs_to :processed_image, class_name: 'Image'
end
