#!/usr/bin/env ruby

DICTFILE = "/usr/share/dict/words"

# Get word list.
begin
    words = File.readlines(DICTFILE)
rescue
    puts "#{$0}: Error reading file " + DICTFILE + "\n#{$0}: Quitting :-("
    exit(1)
end

# Filter list to words containing only a-z, with more than two characters.
validWords = []
words.each {
    |i|
    i.chomp!
    validWords.push(i) if i.length > 2 and i.match(/^[[:lower:]]+$/)
}

# Game loop.
while true
    lives = 9
    found = "-" * (wordCopy = (toGuess = validWords[rand(validWords.count)]).dup).length
    tried = []
    while toGuess.length > 0 and lives > 0
        puts found, "Letters tried: #{tried.sort.join}"
        print "You have #{lives} lives. Guess a letter? "
        print "? " while (letter = gets.chomp).length != 1 or not letter.match(/^[[:lower:]]+$/)
        i = -1
        found[i] = letter while (i = wordCopy.index(letter, i + 1)) != nil
        (toGuess.delete!(letter) if toGuess.include?(letter)) or lives -= 1 if not tried.include?(letter)
        tried.push(letter) if not tried.include?(letter)
    end
    puts "You got #{wordCopy}." if lives > 0 or puts "It was #{wordCopy}."
    print "Another go (y/n)? "
    break if (letter = gets.chomp) != 'y'
end

