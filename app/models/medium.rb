class Medium < ActiveRecord::Base
  before_destroy :delete_file
  def url
    "/uploads/#{filename}" if filename
  end

  private
  def delete_file
    File.delete Rails.root.join("public", "uploads", filename) if filename
  end
end
