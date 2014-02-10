class AddEmailSummaryFrequencyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_summary_frequency, :string
  end
end
