class Article < ActiveRecord::Base
  belongs_to :user

  def self.search(params)
    articles=Article.where("articles.title LIKE ?","%#{params[:query]}%")
    return articles
  end
end
