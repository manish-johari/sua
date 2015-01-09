class Profile::Image < Attachment

  has_attached_file :media, :styles => { :small => "200x150>", :large => "400x300>" }
  validates_attachment :media, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

end
