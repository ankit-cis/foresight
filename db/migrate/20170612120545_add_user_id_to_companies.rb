class AddUserIdToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_reference :companies, :user, type: :uuid, foreign_key: true    
  end
end
