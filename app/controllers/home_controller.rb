class HomeController < ApplicationController


  def index
    
  end

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
        # break if i == 2
        break if page.link_with(text: 'Next Page ').blank?
        page = page.link_with(text: 'Next Page ').click
      end
      article_list = page.search('.article-list .item-content')

      article_list.each do |article|
        article_url  = article.at('h3 a')['href']
        article_page = agent.get(article_url)
        article_text = article_page.search('div .article-content p').to_html
        # article_page.search('div .article-content p').text.gsub(/\n\r\n\t\t\t.*\n.*/, '')
        
        article_text = article_text.slice(0..article_text.index(/<a style="display:block;" href="http:\/\/medici.letstalkpayments.com\/">/)).gsub(/\n\r\n\t\t.*/, '') rescue ''
        next if article_text.blank?
        title = article.at('.entry-title').text
        posted_at = article.at('h4').text.gsub!(/&nbsp.*/, '')
        posted_by = article.at('h4').text.gsub!(/.*&nbspBy\s\:/, '')

        Insight.find_or_create_by(title: title, posted_at: posted_at, posted_by: posted_by,  article_text: article_text)
      end
      first_page = false
    end
  end


  def news_scrap
    # @article = Article.new
    # insights_articles = []
    i = 0
    agent = Mechanize.new
    url = 'https://letstalkpayments.com/tag/news/'
    page = agent.get(url)

    next_page = page.link_with(text: 'Next Page ').href
    first_page = true

    while next_page.present?
      puts "#{i+=1}"
      unless first_page
        # break if i == 8
        break if page.link_with(text: 'Next Page ').blank?
        page = page.link_with(text: 'Next Page ').click
      end
      article_list = page.search('.article-list .item-content')

      article_list.each do |article|
        article_url  = article.at('h3 a')['href']
        article_page = agent.get(article_url)
        article_text = article_page.search('div .article-content p').to_html
        # article_page.search('div .article-content p').text.gsub(/\n\r\n\t\t\t.*\n.*/, '')
        
        article_text = article_text.slice(0..article_text.index(/<a style="display:block;" href="http:\/\/medici.letstalkpayments.com\/">/)).gsub(/\n\r\n\t\t.*/, '') rescue ''
        next if article_text.blank?
        title = article.at('.entry-title').text 
        posted_at = article.at('h4').text.gsub!(/&nbsp.*/, '')
        posted_by = article.at('h4').text.gsub!(/.*&nbspBy\s\:/, '')

        NewsArticle.find_or_create_by(title: title, posted_at: posted_at, posted_by: posted_by,  article_text: article_text)
      end
      first_page = false
    end
  end
end
