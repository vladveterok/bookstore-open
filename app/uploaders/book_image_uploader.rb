class BookImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*_)
    'default_book.jpg'
  end

  version :latest_books do
    process resize_to_fit: [250, 400]
  end

  version :catalog do
    process resize_to_fit: [156, nil]
  end

  version :preview do
    process resize_to_fit: [172, nil]
  end

  version :full do
    process resize_to_fit: [550, nil]
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end
end
