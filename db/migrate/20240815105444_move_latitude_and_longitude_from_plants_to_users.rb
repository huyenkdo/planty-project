class MoveLatitudeAndLongitudeFromPlantsToUsers < ActiveRecord::Migration[7.1]
  def change
    # Supprimer les colonnes de la table plants
    remove_column :plants, :latitude, :float
    remove_column :plants, :longitude, :float

    # Ajouter les colonnes à la table users
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
  end
end
