# Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'
# Paperclip::Attachment.default_options[:s3_host_name] = 's3-us-west-2.amazonaws.com'
# Paperclip::Attachment.default_options[:path] = ":rails_root/public/images"
Paperclip::Attachment.default_options[:storage] = :s3

Paperclip::Attachment.default_options[:s3_credentials] = {
  bucket:  ENV['S3_BUCKET_NAME'],
  access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  s3_region: 'us-west-2'
}
# Paperclip::Attachment.default_options[:s3_options] = {
#    endpoint: 'https://test-event-app-rails.s3.us-west-2.amazonaws.com'
#  }

Paperclip.interpolates(:s3_eu_url) do |attachment, style|
  "#{attachment.s3_protocol}://s3.eu-west-2.amazonaws.com/#{attachment.bucket_name}/#{attachment.path(style).gsub(%r{^/}, '')}"
end
Paperclip::Attachment.default_options[:url] = ':s3_eu_url'
Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'
Paperclip::Attachment.default_options[:s3_host_name] = 's3.us-west-2.amazonaws.com'
