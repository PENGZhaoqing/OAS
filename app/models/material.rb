class Material < ActiveRecord::Base
  attr_accessor :file
  has_attached_file :file
  belongs_to :user
  validates_attachment_content_type :file, :content_type => ["application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/octet-stream"]

  def self.search(params)
    materials=Material.where("materials.file_file_name LIKE ?", "%#{params[:query]}%")
     return materials
  end

end
