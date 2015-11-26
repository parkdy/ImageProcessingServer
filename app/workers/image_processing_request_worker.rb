require 'RMagick'

class ImageProcessingRequestWorker
  include Sidekiq::Worker

  def perform(image_processing_request_id)
    # Fetch request from database
    request = ImageProcessingRequest.find(image_processing_request_id)
    return if request.processed?

    # Download the original file from S3 as a temporary file
    temp_original_file = open(request.original_image.image.url)

    # Image Magick
    img = Magick::Image.from_blob(temp_original_file.read).first
    processed_img = img.negate # change based on command string
    temp_processed_file = Tempfile.new(["processed_#{image_processing_request_id}_", ".#{processed_img.format.downcase}"])
    processed_img.write(temp_processed_file.path)

    processed_image = Image.new
    processed_image.image = temp_processed_file
    request.processed_image = processed_image
    request.processed = true
    request.save!
  end
end
