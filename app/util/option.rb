class Option
  attr_reader(:options)
  def initialize
    @options = {}
    OptionParser.new do |opts|
      opts.banner = "Usage: googlecli.rb [options] [search query]"

      opts.on("-l", "--lucky", "I'm Feeling Lucky") do |l|
        options[:lucky] = l
      end
      opts.on("-w", "--web", "Open in Browser") do |w|
        options[:web] = w
      end
      opts.on_tail("--version", "Show version") do
        puts ::Version
        exit
      end
    end.parse!
  end
end