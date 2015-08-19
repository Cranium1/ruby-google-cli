class WebSearch
  def self.browser_search(query)
    @query = Query::escape_query(query)
    case query
    when ""
      Util::openlink("https://www.google.com/")
    else
      Util::openlink("https://www.google.com/search?q=#{query}")
    end
    exit 0
  end
end


class QueryFetcher
  attr_reader(:results)

  def initialize(query, config, cache)
    @query = Query::escape_query(query)
    @config = config
    @cache = cache
    self.search(query)
  end

  def get_url(query)
    "https://www.googleapis.com/customsearch/"\
    "v1?q=#{query}&cx=#{@config["custom_search"]}&key=#{@config["api_key"]}"
  end

  def search(query)
    if @cache.cache.include?(query)
      @results = @cache.get(query)
    else
      request_json = JSON.load(open(self.get_url(query)))
      @results = request_json["items"].to_a.collect do |element|
        {
          "title" => element["title"],
          "link" => element["link"],
          "desc" => element["snippet"]
        }
      end
      @cache.set(query, @results)
    end
  end
end

