class ImageProcessingRequest < ActiveRecord::Base
  belongs_to :original_image, class_name: 'Image'
  belongs_to :processed_image, class_name: 'Image'

  accepts_nested_attributes_for :original_image
end
