class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :posted_at
      t.string :posted_by

      t.timestamps null: false
    end
  end
end
