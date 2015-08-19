class Application
  def initialize(config={}, options={})
    @options = options
    @config = config

    self.app_start
    self.app_loop
  end

  def app_start
    @query = Query::get_query(@options[:web])

    cache = QueryCache.new
    
    @results = QueryFetcher.new(@query, @config["google"], cache).results

    if @options[:lucky]
      Util::openlink(@results[0]["link"])
      exit 0
    end

    @control = WindowControl.new(@results)
  end

  def app_loop
    while true
      @control.show_single_key
    end
  end
end
