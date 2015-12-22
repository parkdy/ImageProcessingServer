require "rails_helper"

RSpec.describe ImageProcessingRequestsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/image_processing_requests").to route_to("image_processing_requests#index")
    end

    it "routes to #new" do
      expect(:get => "/image_processing_requests/new").to route_to("image_processing_requests#new")
    end

    it "routes to #show" do
      expect(:get => "/image_processing_requests/1").to route_to("image_processing_requests#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/image_processing_requests/1/edit").to route_to("image_processing_requests#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/image_processing_requests").to route_to("image_processing_requests#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/image_processing_requests/1").to route_to("image_processing_requests#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/image_processing_requests/1").to route_to("image_processing_requests#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/image_processing_requests/1").to route_to("image_processing_requests#destroy", :id => "1")
    end

  end
end
