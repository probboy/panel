json.extract! cohort, :id, :name, :begin_date, :end_date, :is_active, :comments, :created_at, :updated_at
json.url cohort_url(cohort, format: :json)
