require 'json'

all_sets_file = File.read('AllSets.json')
all_sets_json = JSON.parse(all_sets_file)

trimmed_json = {}

trimmed_sets = []

all_sets_json.each do |set|
  trimmed_sets << {
    "#{set[0]}": {
      name: set[1]['name'],
      releaseDate: set[1]['releaseDate'],
      cards: set[1]['cards'].map { |card| card['name'] }.uniq
    }
  }
end

trimmed_sets.sort_by! do |h|
  key, value = h.first
  value[:releaseDate].split('-')
end

trimmed_sets.each { |set| trimmed_json.merge!(set) }

File.open('Trimmed.json', 'w') { |f| f.write(JSON.pretty_generate(trimmed_json)) }
