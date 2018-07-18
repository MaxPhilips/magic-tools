# card manager

## install stuff

### electron

    npm i -D electron@latest

### ruby 2.5.0

### bundle install

## update AllCards.json

    wget -qO- -O tmp.zip https://mtgjson.com/json/AllCards.json.zip && unzip tmp.zip && rm tmp.zip

## run

    ruby card_manager.rb
