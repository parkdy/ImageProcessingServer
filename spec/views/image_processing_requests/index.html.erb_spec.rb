require 'rails_helper'

RSpec.describe "image_processing_requests/index", type: :view do
  before(:each) do
    assign(:image_processing_requests, [
      ImageProcessingRequest.create!(
        :original_image_id => 1,
        :processed_image_id => 2,
        :processed => false,
        :command_string => "Command String",
        :callback_url => "Callback Url"
      ),
      ImageProcessingRequest.create!(
        :original_image_id => 1,
        :processed_image_id => 2,
        :processed => false,
        :command_string => "Command String",
        :callback_url => "Callback Url"
      )
    ])
  end

  it "renders a list of image_processing_requests" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Command String".to_s, :count => 2
    assert_select "tr>td", :text => "Callback Url".to_s, :count => 2
  end
end
