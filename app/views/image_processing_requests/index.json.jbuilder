json.array!(@image_processing_requests) do |image_processing_request|
  json.extract! image_processing_request, :id, :original_image_id, :processed_image_id, :processed, :command_string, :callback_url
  json.url image_processing_request_url(image_processing_request, format: :json)
end
