class CreateListUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :list_users do |t|
      t.belongs_to :user
      t.belongs_to :list

      t.timestamps
    end
  end
end
