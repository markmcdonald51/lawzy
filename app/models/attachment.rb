class Attachment < ApplicationRecord
  acts_as_list
  belongs_to :attachable, polymorphic: true

  has_attached_file :asset,
    # :processors => [:cropper],
    :styles => {  :large => '500x500', :medium => "800x300", :thumb => "100x100>" },
    :default_url => "/images/:style/missing.png"

  validates_attachment_content_type :asset, :content_type => /\Aimage\/.*\Z/

  #has_paper_trail
  #crop_attached_file :asset, :aspect => "16:9"

=begin
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_asset, :if => :cropping?

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  # http://railscasts.com/episodes/182-cropping-images
  #def asset_geometry(style = :original)
  #  @geometry ||= {}
  #  @geometry[style] ||= Paperclip::Geometry.from_file(asset.path(style))
  #end
=end

=begin
  has_attached_file :asset #, styles: {thumbnail: "60x60#"}

  validates_attachment :asset, content_type: { content_type: "application/pdf" }

  validates_attachment_file_name :asset,
      matches:   [/pdf\Z/, /doc\Z/, /docx\Z/],
      message:   ', Only PDF or WORD files are allowed. '

=end

=begin
  validates_attachment :asset,
    presence: true,
    content_type: { content_type: ["image/jpeg", "application/pdf"] },
    size:         { less_than: 5.megabytes },
    file_name:    { matches: [/png\Z/, /jpe?g\=end


  validates_attachment_size :asset, less_than: 4.megabytes
  validates_attachment_file_name :asset,
      matches:   [/pdf\Z/, /doc\Z/, /docx\Z/],
      message:   ', Only PDF or WORD files are allowed. '

=end
  #validates_with AttachmentSizeValidator, attributes: :asset, :less_than => 6.megabytes
  #validates_attachment :asset, content_type: { content_type: "application/pdf" }

  def to_label
    asset_file_name
  end

  private

end
