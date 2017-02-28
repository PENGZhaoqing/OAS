class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :department

  def self.search(params)
    articles=Article.where("articles.title LIKE :title and articles.kind= :kind ",title: "%#{params[:query]}%",kind: params[:kind])
    return articles
  end
end
