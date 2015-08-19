class Query
	def self.get_query(webflag)
		query = Query::get_query_from_arg
		if webflag
			WebSearch::browser_search(query)
    	end
		if query == ""
      		query = Query::get_query_from_user
   		end
   		query
	end
	def self.get_query_from_arg
		ARGV.join("+")
	end

	def self.get_query_from_user
		Interface::prompt_user
		a = gets.chomp
		a.split(" ").join("+")
	end

	def self.escape_query(query)
		URI.escape(query.split(" ").join("+"))
	end
end