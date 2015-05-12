class Answers < ActiveRecord::Migration
  def change
    create_table(:answers) do |t|
      t.column(:answer, :string)
      t.column(:question_id, :integer)
    end
    
    add_column(:questions, :answer, :string)
  end
end
