module Util
	def self.openlink(link)
		esc_link = URI.escape(link)
		system("open \"#{esc_link}\"")
	end

	def self.escape_query(query)
		URI.escape(query.split(" ").join("+"))
	end

	def self.google_search(query)
   		case escape_query(query)
 		when ""
 			openlink("https://www.google.com/")
  		else
    		openlink("https://www.google.com/search?q=#{query}")
    	end
 	end
end