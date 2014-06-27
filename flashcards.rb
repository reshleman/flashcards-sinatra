require "sinatra"
require "active_record"

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "flashcard-sinatra"
)

class Deck < ActiveRecord::Base
  has_many :cards
end

class Card < ActiveRecord::Base
end

get "/" do
  @decks = Deck.order("name ASC")
  erb :index
end

get "/decks/new" do
  erb :new_deck
end

get "/decks/:deck_id" do
  @deck = Deck.find(params[:deck_id])
  @cards = @deck.cards
  erb :show_deck
end

post "/decks" do
  @deck = Deck.create(params["deck"])
  redirect to("/decks/#{@deck.id}")
end

get "/decks/:deck_id/cards/new" do
  @deck = Deck.find(params[:deck_id])
  erb :new_card
end

post "/decks/:deck_id/cards" do
  @card = Card.create(params[:card])
  redirect to("/decks/#{@card.deck_id}")
end
