require 'rails_helper'

RSpec.describe "image_processing_requests/new", type: :view do
  before(:each) do
    assign(:image_processing_request, ImageProcessingRequest.new(
      :original_image_id => 1,
      :processed_image_id => 1,
      :processed => false,
      :command_string => "MyString",
      :callback_url => "MyString"
    ))
  end

  it "renders new image_processing_request form" do
    render

    assert_select "form[action=?][method=?]", image_processing_requests_path, "post" do

      assert_select "input#image_processing_request_original_image[name=?]", "image_processing_request[original_image_attributes][image]"

      assert_select "input#image_processing_request_command_string[name=?]", "image_processing_request[command_string]"

      assert_select "input#image_processing_request_callback_url[name=?]", "image_processing_request[callback_url]"
    end
  end
end
