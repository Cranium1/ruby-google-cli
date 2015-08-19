class QueryCache
  attr_reader(:cache)
  def initialize
    @cache = []
    Dir.mkdir('cache') unless File.exists?('cache')
    Dir.foreach('cache') do |item|
      next if item == '.' or item == '..'
      @cache << item
    end
  end
  def get(query)
    if @cache.include?(query)
      JSON.load(File.read("cache/#{query}"))
    end
  end
  def set(query, data)
    if !@cache.include?(query)
      a = JSON.dump(data)

      File.open("cache/#{query}", "w") do |f|
        f.puts a
      end

      @cache << query

      return true
    end
  end
end