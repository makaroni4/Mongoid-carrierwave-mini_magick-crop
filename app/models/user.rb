# coding: UTF-8
class User
  include Mongoid::Document
  attr_accessor :crop_x, :crop_y, :crop_h, :crop_w, :resolution
  
  field :username
  
  mount_uploader :profile, ProfileUploader

  def profile_geometry
    img = MiniMagick::Image.open("http://localhost:3000" + self.profile_url)
    @geometry = {:width => img[:width], :height => img[:height] }
  end
  
  def crop
    img = Magick::Image::read(self.profile.current_path).first
    img.crop!(self.crop_x.to_i, self.crop_y.to_i, self.crop_w.to_i, self.crop_h.to_i)

    width, height = self.resolution.split("х")
    img.resize!(width.to_i, height.to_i)
    img.write(self.profile.send("s#{self.resolution}".to_sym).current_path)

  end
end