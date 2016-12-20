json.extract! news_article, :id, :title, :posted_at, :posted_by, :article_text, :created_at, :updated_at
json.url news_article_url(news_article, format: :json)