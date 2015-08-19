class WindowControl
  def initialize(results)
    @index = 0
    @results = results
    Interface::render_page(@results, @index)
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

  def show_single_key
    c = read_char

    case c
    when "\r"
      Util::openlink(@results[@index]["link"])
    when "\e[A" #UP ARROW
      if @index != 0
        @index -= 1
      end
    when "\e[B" #DOWN ARROW
      if @index != @results.length-1
        @index += 1
      end
    when "\u0003", "\e"
      exit 0
    end
    Interface::render_page(@results, @index)
  end
end


class Interface
  def self.render_page(results, index)
   system "clear" or system "cls"
   item = results[index]
   puts "    ------------------<< Search Result #{index+1}  >>---------------".yellow
   puts
   puts " >> ".red+item["title"].upcase
   puts " >> ".red+item["link"].green
   puts " >> ".red+item["desc"]
 end

  def self.prompt_user
    system "clear" or system "cls"
    puts nil
    puts nil
    puts "          Google Cli"
    puts nil
    puts "            V.01"
    puts nil
    puts "      Enter Search Query:"
    puts nil
    puts nil
  end
end