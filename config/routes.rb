Rails.application.routes.draw do
  resources :enrollments
  resources :students
  resources :cohorts
  root :to => "access#login"

  get "show/:permalink", :to => "public#show", :as => "public_show"

  get "admin", :to => "access#menu"
  get "access/menu"
  get "access/login"
  post "access/attempt_login"
  get "access/logout"

  resources :admin_users, :except => [:show] do
    member do
      get :delete
    end
  end

  resources :subjects do
    member do
      get :delete
    end
  end

  resources :pages do
    member do
      get :delete
    end
  end

  resources :sections do
    member do
      get :delete
    end
  end

  get "/students/:student_id/cohorts/:cohort_id", to: "students#associate_student_to_cohort", as: :student_cohort
  get "/cohorts/:cohort_id/students/:student_id", to: "cohorts#associate_cohort_to_student", as: :cohort_student

  # default route
  # may go away in future versions of Rails
  # get ':controller(/:action(/:id))'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
