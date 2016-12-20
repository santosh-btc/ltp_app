class CreateNewsArticles < ActiveRecord::Migration
  def change
    create_table :news_articles do |t|
      t.string :title
      t.string :posted_at
      t.string :posted_by
      t.text :article_text

      t.timestamps null: false
    end
  end
end
