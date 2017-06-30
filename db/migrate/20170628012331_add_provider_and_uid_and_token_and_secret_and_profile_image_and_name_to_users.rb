class AddProviderAndUidAndTokenAndSecretAndProfileImageAndNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :Uid, :string
    add_column :users, :Token, :string
    add_column :users, :Secret, :string
    add_column :users, :profile_image, :string
    add_column :users, :name, :string
  end
end
