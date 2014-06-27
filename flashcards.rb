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
