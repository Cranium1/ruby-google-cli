class Query
	def initialize(render)
		@render = render
	end
	def get_query(webflag)
		query = self.get_query_from_arg
		if webflag
			Util::google_search(query)
			exit 0
    	end
		if query == ""
      		query = self.get_query_from_user
   		end
   		query
	end
	def get_query_from_arg
		ARGV.join("+")
	end

	def get_query_from_user
		@render.prompt_user
		a = gets.chomp
		a.split(" ").join("+")
	end
end