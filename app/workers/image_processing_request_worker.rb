class ImageProcessingRequestWorker
  include Sidekiq::Worker

  def perform(image_processing_request_id)
    request = ImageProcessingRequest.find(image_processing_request_id)
    return if request.processed?

    original_image = MiniMagick::Image.open(request.original_image.image.url)
    processed_image_path = processed_image_path(request)

    convert(original_image, request, processed_image_path)

    process_request!(request, processed_image_path)

    send_callback_request(request) if request.callback_url.present?
  end

  private

  def processed_image_path(request)
    output_filename = request.command_string.split.last
    Rails.root.join('tmp', "processed_#{request.id}_#{output_filename}")
  end

  def convert(original_image, request, processed_image_path)
    MiniMagick::Tool::Convert.new do |convert|
      convert << original_image.path
      convert.merge!(request.command_string.split[0..-2])
      convert << processed_image_path
    end
  end

  def process_request!(request, processed_image_path)
    request.update_attributes!(
      processed_image: Image.new(image: open(processed_image_path)),
      processed: true
    )
  end

  def send_callback_request(request)
    params = {
      image_processing_request: {
        id: request.id,
        processed_image_url: request.processed_image.image.url
      }
    }

    RestClient.post(request.callback_url, params: params,
                                          content_type: :json,
                                          accept: :json)
  end
end
