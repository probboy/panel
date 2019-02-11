class CreateCohorts < ActiveRecord::Migration[5.0]
  def change
    create_table :cohorts do |t|
      t.string :name
      t.date :begin_date
      t.date :end_date
      t.boolean :is_active
      t.string :comments

      t.timestamps
    end
  end
end
