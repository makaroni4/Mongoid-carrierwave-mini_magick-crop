class User
  include Mongoid::Document

  attr_accessor :crop_x, :crop_y, :crop_h, :crop_w
  after_update :reprocess_profile, :if => :cropping?
  
  field :username
  
  mount_uploader :profile, ProfileUploader

  def cropping?
    !crop_x.blank? and !crop_y.blank? and !crop_h.blank? and !crop_w.blank?
  end

  def profile_geometry
    img = MiniMagick::Image.open(self.profile.large.path)
    @geometry = {:width => img[:width], :height => img[:height] }
  end

  private

  def reprocess_profile
    img = MiniMagick::Image.open(self.profile.large.path)
    crop_params = "#{crop_w}x#{crop_h}+#{crop_x}+#{crop_y}"
    img.crop(crop_params)
    img.write(self.profile.path)
    profile.recreate_versions!
  end
  
end
