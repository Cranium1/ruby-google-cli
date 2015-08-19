class Util
	def self.openlink(link)
		esc_link = URI.escape(link)
		system("open \"#{esc_link}\"")
	end
end