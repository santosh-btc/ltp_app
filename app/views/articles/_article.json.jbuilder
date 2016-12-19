json.extract! article, :id, :title, :posted_at, :posted_by, :url, :created_at, :updated_at
json.url article_url(article, format: :json)