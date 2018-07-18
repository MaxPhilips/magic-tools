require 'flammarion'
require 'json'

f = Flammarion::Engraving.new
f.pane('default').hide

file = File.read('AllCards.json')
json_hash = JSON.parse(file)

card_names = json_hash.keys

textbox = f.pane('textbox')
cards = f.pane('cards')
textbox.style('height', '10%')
cards.style('height', '90%')

textbox.input('card name', autoclear: true) do |msg|
  cards.clear

	card_names.each do |card_name|
    if card_name =~ /#{msg['text']}/i
      cards.button(card_name) do
        cards.clear
      end
    end
  end
end

f.wait_until_closed
