require 'rails_helper'

RSpec.describe "ImageProcessingRequests", type: :request do
  describe "GET /image_processing_requests" do
    it "works! (now write some real specs)" do
      get image_processing_requests_path
      expect(response).to have_http_status(200)
    end
  end
end
