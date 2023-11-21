class String
  def numeric?
    Float(self) != nil rescue false
  end
end

def rpn_generate(text)
  if text.count('(') != text.count(')')
    return "Wrong brackets"
  end
  priorites = {
    '+' => 1,
    '-' => 1,
    '*' => 2,
    '/' => 2,
    '^' => 3
  }
  symbols = text.split
  stack = []
  res = []
  symbols.each do |sym|
    if sym == '('
      stack << sym
    elsif sym == ')'
      while stack.length > 0
        x = stack.pop
        if x == '('
          break
        end
        res << x
      end
    elsif sym.numeric?
      res << sym
    elsif priorites[sym] != nil
      while stack.length > 0 and stack[-1] != '(' and priorites[sym] <= priorites[stack[-1]]
        res << stack.pop
      end
      stack << sym
    else
      return "Cant parse this string"
    end
  end
  while stack.length > 0
    res << stack.pop
  end
  res.join ' '
end

if __FILE__ == $0
  loop do
    puts "Enter expression or 'exit' (use spaces between operands)"
    text = gets.chomp
    break if text == "exit"
    puts "Result:"
    puts rpn_generate text
  end
end