class CreateUserAuthenticationTokens < ActiveRecord::Migration
  def change
    create_table :user_authentication_tokens do |t|
      t.string :token
      t.references :user

      t.timestamps
    end
  end
end
