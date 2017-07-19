class Photo < ApplicationRecord
  has_one :tutorial
  has_attached_file :image,
                    :processors => [:thumbnail, :paperclip_optimizer],
                    :styles => {
                      :thumb_160 => "160x160#",                        
                      :thumb_480 => "480x320>",
                      :thumb_100 => "100×100>",
                      :thumb_80 => "80×80>"                      
                    },
                    :convert_options => {
                      :all => "-strip"
                    },
                    :default_url => "no_image.png",
                    :preserve_files => "true",
                    :storage => :s3,
                    :path => ":attachment/:id/:style.:extension",                    
                    :s3_permissions => :private,
                    :bucket => ENV['S3_BUCKET'],
                    :s3_region => ENV['AWS_REGION'],
                    :s3_host_name   => ENV['S3_HOST_NAME'],
                    :s3_credentials => {
                      :access_key_id => ENV['AWS_ACCESS_KEY'],
                      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
                    },
                    # :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :s3_protocol => :https,
                    :s3_headers => { 'Cache-Control' => 'max-age=2592000' }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_attachment_file_name :image, :matches => [/png\Z/i, /jpe?g\Z/i]

  def image_url
    image.url()
  end

  def thumb_80
    image.url(:thumb_80)
  end

  def thumb_100
    image.url(:thumb_100)
  end

  def thumb_160
    image.url(:thumb_160)
  end

  def thumb_480
    image.url(:thumb_480)
  end
end
