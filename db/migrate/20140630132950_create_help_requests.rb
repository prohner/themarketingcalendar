class CreateHelpRequests < ActiveRecord::Migration
  def change
    create_table :help_requests do |t|
      t.string :email
      t.string :subject
      t.text :description

      t.timestamps
    end
  end
end
