class AddingTables < ActiveRecord::Migration
  def change
    create_table(:surveys) do |t|
      t.column(:title, :string)
    end
    create_table(:questions) do |t|
      t.column(:question, :string)
      t.column(:survey_id, :integer)
    end
  end
end
