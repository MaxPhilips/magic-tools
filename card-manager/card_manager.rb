require 'flammarion'
require 'json'

@f = Flammarion::Engraving.new
@card = '--'

def input_list; @f.pane('inputlist', weight: 0.5); end
def card_details; @f.pane('carddetails', weight: 0.5); end

input_list

card_details
card_details_name = card_details.subpane('carddetailsname')
card_details_name.puts(@card)
quantity = card_details.input('quantity')
set = card_details.input('set')
card_details.button('add card') do
  @f.status("added [#{quantity.value}] copies of card [#{@card}] from set [#{set.value}] to collection")
  @card = '--'
  card_details_name.replace(@card)
  quantity.clear
  set.clear
end

@f.orientation = :horizontal
@f.pane('default').hide

all_cards_file = File.read('AllCards.json')
all_cards_json = JSON.parse(all_cards_file)
card_names = all_cards_json.keys


input_list.input('card name', autoclear: true) do |msg|
  input_list.subpane('card_buttons').clear

  card_names.each do |card_name|
    if card_name =~ /#{msg['text']}/i
      input_list.subpane('card_buttons').button(card_name) do
        input_list.subpane('card_buttons').clear
        card_details_name.replace(card_name)
        @card = card_name
      end
    end
  end
end
card_buttons = input_list.subpane('card_buttons')

@f.wait_until_closed
