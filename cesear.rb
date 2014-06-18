

def ceasarLetter(letter, value)
  temp = ('a'..'z').to_a
  temp.map! { |a| a.upcase } if letter == letter.upcase

  return letter if !temp.index(letter)
  temp[(temp.index(letter) + value) % temp.length]
end

string = ARGV[0] || "Enter a string!"
value = ARGV[1].to_i || 0

code = []
string.split('').each do |letter|
  code << ceasarLetter(letter, value)
end

print code.join("")
