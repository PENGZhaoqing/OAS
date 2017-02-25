class Department < ActiveRecord::Base
  has_one :article,:dependent => :destroy
  has_many :users


  def self.search(params)
    departments=Department.where("departments.name LIKE ?", "%#{params[:query]}%")
    return departments
  end
end
