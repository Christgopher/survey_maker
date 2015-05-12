class Datatable < ActiveRecord::Migration
  def change
    create_table(:datatables) do |t|
      t.column(:answer_id, :integer)
    end
  end
end
