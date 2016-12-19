class HomeController < ApplicationController

  def article_html
    agent = Mechanize.new
    page = agent.get("https://letstalkpayments.com/fundchain-unveils-first-insight-of-blockchain-proof-of-concept-for-the-investments-funds-industry-the-smart-ta/")
    @page_html = page.search('.article-content').to_html

    render html: @page_html
# 
    # render_to_string(@page_html)
  end


  def insights_scrap
    # @article = Article.new
    # insights_articles = []
    i = 0
    agent = Mechanize.new
    url = 'https://letstalkpayments.com/tag/insights/'
    page = agent.get(url)

    next_page = page.link_with(text: 'Next Page ').href
    first_page = true

    while next_page.present?
      puts "#{i+=1}"
      unless first_page
        break if page.link_with(text: 'Next Page ').blank?
        page = page.link_with(text: 'Next Page ').click
      end
      article_list = page.search('.article-list .item-content')

      article_list.each do |article|
        title = article.at('.entry-title').text
        posted_at = article.at('h4').text.gsub!(/&nbsp.*/, '')
        posted_by = article.at('h4').text.gsub!(/.*&nbspBy\s\:/, '')

        Article.find_or_create_by(title: title, posted_at: posted_at, posted_by: posted_by)
        # insights_articles << {title: title, posted_at: posted_at, posted_by:posted_by}
      end
      first_page = false
    end

    # render json: {
    #     articles: insights_articles
    #   }
    # insights_articles
  end

  def news_scrap
    insights_articles = []
    i = 0
    agent = Mechanize.new
    url = 'https://letstalkpayments.com/tag/insights/'
    page = agent.get(url)

    next_page = page.link_with(text: 'Next Page ').href
    first_page = true

    while next_page.present?
      puts "#{i+=1}"
      unless first_page
        break if page.link_with(text: 'Next Page ').blank?
        page = page.link_with(text: 'Next Page ').click
      end
      article_list = page.search('.article-list .item-content')

      article_list.each do |article|
        title = article.at('.entry-title').text
        posted_at = article.at('h4').text.gsub!(/&nbsp.*/, '')
        posted_by = article.at('h4').text.gsub!(/.*&nbspBy\s\:/, '')

        insights_articles << {title: title, posted_at: posted_at, posted_by:posted_by}
      end
      first_page = false
    end

    render json: {
        articles: insights_articles
      }
    insights_articles
  end
end
