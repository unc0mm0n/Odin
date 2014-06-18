

def ceasarLetter(letter, value)
  temp = ('a'..'z').to_a
  temp.map! { |a| a.upcase } if letter == letter.upcase

  return letter if !temp.index(letter)
  temp[(temp.index(letter) + value) % temp.length]
end


value = ARGV.shift.to_i || 0

string = ''
ARGV.each { |arg| string += "#{arg} " }

code = []
string.split('').each do |letter|
  code << ceasarLetter(letter, value)
end

print code.join("")
