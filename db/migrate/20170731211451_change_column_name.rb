class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :Uid, :uid
    rename_column :users, :Token, :token
    rename_column :users, :Secret, :secret
  end
end
