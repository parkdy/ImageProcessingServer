class ImageProcessingRequestsController < ApplicationController
  before_action :set_image_processing_request, only: [:show, :edit, :update, :destroy]

  # GET /image_processing_requests
  # GET /image_processing_requests.json
  def index
    @image_processing_requests = ImageProcessingRequest.all
  end

  # GET /image_processing_requests/1
  # GET /image_processing_requests/1.json
  def show
  end

  # GET /image_processing_requests/new
  def new
    @image_processing_request = ImageProcessingRequest.new
  end

  # GET /image_processing_requests/1/edit
  def edit
  end

  # POST /image_processing_requests
  # POST /image_processing_requests.json
  def create
    @image_processing_request = ImageProcessingRequest.new(image_processing_request_params)

    respond_to do |format|
      if @image_processing_request.save
        ImageProcessingRequestWorker.perform_async(@image_processing_request.id)

        format.html { redirect_to @image_processing_request, notice: 'Image processing request was successfully created.' }
        format.json { render :show, status: :created, location: @image_processing_request }
      else
        format.html { render :new }
        format.json { render json: @image_processing_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /image_processing_requests/1
  # PATCH/PUT /image_processing_requests/1.json
  def update
    respond_to do |format|
      if @image_processing_request.update(image_processing_request_params)
        format.html { redirect_to @image_processing_request, notice: 'Image processing request was successfully updated.' }
        format.json { render :show, status: :ok, location: @image_processing_request }
      else
        format.html { render :edit }
        format.json { render json: @image_processing_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /image_processing_requests/1
  # DELETE /image_processing_requests/1.json
  def destroy
    @image_processing_request.destroy
    respond_to do |format|
      format.html { redirect_to image_processing_requests_url, notice: 'Image processing request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_processing_request
      @image_processing_request = ImageProcessingRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_processing_request_params
      params.require(:image_processing_request).permit({original_image_attributes: [:image]}, :command_string, :callback_url)
    end
end
