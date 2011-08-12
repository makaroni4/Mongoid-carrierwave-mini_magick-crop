# encoding: utf-8

class ProfileUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support:
  #include CarrierWave::RMagick
  # include CarrierWave::ImageScience
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  version :large do
    
  end

  version :thumb do
    process :resize_to_fill => [100, 100]
  end

  version :x860 do
    
  end
  
  version :x600 do
  
  end
  
  version :x310 do
    
  end
  
  version :x120 do

  end
end
