# card manager

## install stuff

### electron

    npm i -D electron@latest

### ruby 2.5.0

### bundle install

## update json

    wget -qO- -O tmp.zip https://mtgjson.com/json/AllSets.json.zip && unzip tmp.zip && rm tmp.zip
    ruby organize_json.rb

## run

    ruby card_manager.rb
