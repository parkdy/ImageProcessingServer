require 'rails_helper'

RSpec.describe "image_processing_requests/show", type: :view do
  before(:each) do
    @image_processing_request = assign(:image_processing_request, ImageProcessingRequest.create!(
      :original_image_id => 1,
      :processed_image_id => 2,
      :processed => false,
      :command_string => "Command String",
      :callback_url => "Callback Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Command String/)
    expect(rendered).to match(/Callback Url/)
  end
end
