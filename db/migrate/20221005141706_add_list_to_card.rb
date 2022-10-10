class AddListToCard < ActiveRecord::Migration[6.1]
  def change
    add_reference :cards, :list, foreign_key: true
  end
end
