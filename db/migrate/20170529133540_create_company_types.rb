class CreateCompanyTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :company_types, id: :uuid do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
