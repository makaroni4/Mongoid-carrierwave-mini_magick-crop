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
    path = RAILS_ROOT + "/public" + self.profile_url
    thumb_path = RAILS_ROOT + "/public" + self.profile.send("s#{self.resolution}".to_sym).url
    self.profile.send("s#{self.resolution}".to_sym).crop("#{self.crop_h.to_i}x#{self.crop_w.to_i}+#{self.crop_x.to_i}+#{self.crop_y.to_i}")
#     magic = "convert #{path} -crop #{self.crop_h.to_i}x#{self.crop_w.to_i}+#{self.crop_x.to_i}+#{self.crop_y.to_i} -resize #{self.resolution} "+ self.profile.send("s#{self.resolution}".to_sym).current_path
#     system magic
    self.profile.send("s#{self.resolution}".to_sym).resize(self.resolution)
    puts magic
#     puts "#{self.crop_w.to_i}x#{self.crop_h.to_i}+#{self.crop_y.to_i}+#{self.crop_x.to_i}"
  end
end