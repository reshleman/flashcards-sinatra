require "sinatra"
require "active_record"

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "flashcards-sinatra"
)

class Deck < ActiveRecord::Base
  has_many :cards
end

class Card < ActiveRecord::Base
end

# GET index
get "/" do
  @decks = Deck.order("name ASC")
  erb :index
end

# GET new deck form
get "/decks/new" do
  erb :new_deck
end

# POST new deck
post "/decks" do
  @deck = Deck.create(params["deck"])
  redirect to("/decks/#{@deck.id}")
end

# GET view for a deck
get "/decks/:deck_id" do
  @deck = Deck.find(params[:deck_id])
  @cards = @deck.cards
  erb :show_deck
end

# GET edit deck form
get "/decks/:deck_id/edit" do
  @deck = Deck.find(params[:deck_id])
  erb :edit_deck
end

# PUT edited deck
put "/decks/:deck_id" do
  @deck = Deck.find(params[:deck_id])
  @deck.update(params[:deck])
  redirect to("/decks/#{@deck.id}")
end

# GET new card form
get "/decks/:deck_id/cards/new" do
  @deck = Deck.find(params[:deck_id])
  erb :new_card
end

# POST new card
post "/decks/:deck_id/cards" do
  @card = Card.create(params[:card])
  redirect to("/decks/#{@card.deck_id}")
end
