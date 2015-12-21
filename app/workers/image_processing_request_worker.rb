class ImageProcessingRequestWorker
  include Sidekiq::Worker

  def perform(image_processing_request_id)
    request = ImageProcessingRequest.find(image_processing_request_id)
    return if request.processed?

    original_image = MiniMagick::Image.open(request.original_image.image.url)
    processed_image_path = Rails.root.join('tmp', "processed_#{image_processing_request_id}_#{request.command_string.split.last}")

    MiniMagick::Tool::Convert.new do |convert|
      convert << original_image.path
      convert.merge!(request.command_string.split[0..-2])
      convert << processed_image_path
    end

    request.update_attributes!(
      processed_image: Image.new(image: open(processed_image_path)),
      processed: true
    )
  end
end
