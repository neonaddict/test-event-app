Paperclip::Attachment.default_options[:styles] = { thumb: "100x100#",  small: "200x200#",  medium: "300x300#"}
Paperclip::Attachment.default_options[:default_url] = "/images/:style/missing.png"
#Paperclip::Attachment.default_options[:path] = ":rails_root/public/images"