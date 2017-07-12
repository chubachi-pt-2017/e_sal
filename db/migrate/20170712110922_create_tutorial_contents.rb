class CreateTutorialContents < ActiveRecord::Migration[5.0]
  def change
    create_table :tutorial_contents do |t|
      t.references :tutorial, null: false, index: true
      t.text :body
      t.timestamps
    end
  end
end
