json.extract! insight, :id, :title, :posted_at, :posted_by, :article_text, :created_at, :updated_at
json.url insight_url(insight, format: :json)