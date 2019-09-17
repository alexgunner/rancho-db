class AddAttachmentPictureToCombos < ActiveRecord::Migration[5.1]
  def self.up
    change_table :combos do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :combos, :picture
  end
end
