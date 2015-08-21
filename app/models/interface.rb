class UserInput
  def lock_window
    print "\033[?1049h\033[H"
  end

  def unlock_window
    print "\033[?1049l"
  end

  def read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
  ensure
    STDIN.echo = true
    STDIN.cooked!
    return input
  end

  def receive_key(index)
    case read_char
    when "\r"
      return "return"
    when "\e[A"
      return "up"
    when "\e[B"
      return "down"
    when "\u0003", "\e", "q"
      return "quit"
    end
  end
end


class RenderPage
  def self.page(name, *args, &block)
    if args == []
      define_method(name) do
        system "clear" or system "cls"
        yield
      end
    else
      define_method(name) do | args |
        system "clear" or system "cls"
        yield(args)
      end
    end
  end

  page(:render_result, :item) do |item|
   puts "    ------------------<< Search Result >>---------------".yellow
   puts
   puts " >> ".red+item["title"].upcase
   puts " >> ".red+item["link"].green
   puts " >> ".red+item["desc"]
  end

  page(:prompt_user) do
    google = "G".blue+"o".red+"o".yellow+"g".blue+"l".green+"e".red
    puts nil
    puts nil
    print "      #{google} Cli V.01 Enter Search Query "+">> ".red
  end
end