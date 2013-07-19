# Put your database migration here!
#
# Each one needs to be named correctly:
# timestamp_[action]_[class]
#
# and once a migration is run, a new one must
# be created with a later timestamp.

# reference
# class CreateProducts < ActiveRecord::Migration
#   def change
#     create_table :products do |t|
#       t.string :name
#       t.text :description
#       t.timestamps
#     end
#   end
# end

class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :longURL
      t.string :shortURL
    end
  end
end
