
if defined?(Paperclip)
	Paperclip.interpolates('page_id') do |attachment, style|
  		attachment.instance.page.id.to_s.parameterize
	end
end

