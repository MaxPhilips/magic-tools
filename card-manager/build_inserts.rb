require 'json'

def pbcopy(input)
  str = input.to_s
  IO.popen('pbcopy', 'w') { |f| f << str }
  str
end

trimmed_file = File.read('Trimmed.json')
trimmed_json = JSON.parse(trimmed_file)

puts 'what set?'
starting_set = gets.chomp
keep_skipping = true

trimmed_json.each do |set|
  set_name = set[1]['name']

  if keep_skipping == true
    unless set_name == starting_set
      next
    else
      keep_skipping = false
    end
  end

  puts '', "now asking about [#{set_name}]", ''
  cards = []
  total_cards = set[1]['cards'].size

  set[1]['cards'].each_with_index do |card, index|
    puts "(#{index + 1}/#{total_cards}) how many [#{card}] do you have?"
    quantity = gets.chomp.to_i

    cards << "(\"#{card}\", \"#{set_name}\", #{quantity})"
  end

  insert_statement = <<~INSERT
    insert into cards(card_name, card_set, card_quantity)
    values #{cards.join(",\n       ")};
  INSERT

  pbcopy(insert_statement)
  puts '', 'copied this to clipboard:', insert_statement
end
