class Application
  def initialize(config={}, options={})
    @options = options
    @config = config

    self.app_start
    self.app_loop
  end

  def app_start
    @input = UserInput.new
    @window = RenderPage.new
    query = Query.new(@window).get_query(@options[:web])
    cache = QueryCache.new
    fetcher = QueryFetcher.new(@config)

    if !(@results = cache.get(query))
      @results = fetcher.fetch_results(query)
      cache.set(query, @results)
    end

    @input.lock_window

    if @options[:lucky]
      Util::openlink(@results[0]["link"])
      self.app_end
    end
  end

  def app_end
    STDIN.echo = true
    STDIN.cooked!
    @input.unlock_window
    exit 0
  end

  def app_loop
    @window.render_result(@results[0])
    index = 0
    loop do
      key = @input.receive_key(index)
      case key
      when "return"
        Util::openlink(@results[index]["link"])
      when "up"
        index -= 1 if index != 0
      when "down"
        index += 1 if index != @results.length-1
      when "quit"
        self.app_end
      end
      current_result = @results[index]
      @window.render_result(current_result)
    end
  end
end
