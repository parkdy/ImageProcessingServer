class CreateImageProcessingRequests < ActiveRecord::Migration
  def change
    create_table :image_processing_requests do |t|
      t.string :callback_url
      t.references :original_image, index: true
      t.references :processed_image, index: true
      t.boolean :processed, default: false, null: false
      t.string :command_string, default: ''

      t.timestamps null: false
    end
  end
end
