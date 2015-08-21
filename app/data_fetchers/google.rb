class QueryFetcher

  attr_reader(:results)

  def initialize(config)
    @config = config
  end

  def get_url(query)
    a = @config["google"]["custom_search"]
    b = @config["google"]["api_key"]
    "https://www.googleapis.com/customsearch/"\
    "v1?q=#{query}&cx=#{a}&key=#{b}"
  end

  def fetch_data(url)
    JSON.load(open(url))
  end

  def get_results(resulthash)
    resulthash["items"].to_a.collect do | result |
    {
      "title" => result["title"],
      "link" => result["link"],
      "desc" => result["snippet"]
    }
    end
  end

  def fetch_results(query)
    query = Util::escape_query(query)
    url = get_url(query)
    get_results(fetch_data(get_url(query)))
  end
end