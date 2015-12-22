require 'rails_helper'

RSpec.describe "image_processing_requests/edit", type: :view do
  before(:each) do
    @image_processing_request = assign(:image_processing_request, ImageProcessingRequest.create!(
      :original_image_id => 1,
      :processed_image_id => 1,
      :processed => false,
      :command_string => "MyString",
      :callback_url => "MyString"
    ))
  end

  it "renders the edit image_processing_request form" do
    render

    assert_select "form[action=?][method=?]", image_processing_request_path(@image_processing_request), "post" do

      assert_select "input#image_processing_request_original_image[name=?]", "image_processing_request[original_image_attributes][image]"

      assert_select "input#image_processing_request_command_string[name=?]", "image_processing_request[command_string]"

      assert_select "input#image_processing_request_callback_url[name=?]", "image_processing_request[callback_url]"
    end
  end
end
