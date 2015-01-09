class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :type
      t.string :media_file_name
      t.string :media_content_type
      t.integer :media_file_size
      t.references :attachable, polymorphic: true

      t.timestamps
    end
  end
end
