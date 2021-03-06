Xcore::Application.routes.draw do

  get "exams/schedule"

  get "exams/confirm_modules"

  get "exams/select_modules"

  get "exams/schedule_an_exam"

  get "exams/dashboard"
  get "exams/live_search"
  post "exams/create_exam_schedule"
  post "exams/confirm_modules"




  get "subjects/select_modules_to_enroll"

  get "programs/select_program_to_enroll"

  get "subjects/details"

  get "programs/details"

  get "subjects/create"
  get "subjects/dashboard"
  get "subjects/show"
  get "subjects/new"
  get "subjects/live_search"
  post "subjects/create"
  get "subjects/select_subjects"

  get "programs/new"
  post "programs/create"
  get "programs/dashboard"
  get "programs/show"
  get "/programs/live_search"
  get "programs/confrim_module_selection"
  post "programs/confrim_module_selection"
  post "programs/create_program_modules_relationship"
  get "programs/select_program"
  post "programs/create_student_program_modules_relationship"

  get "students/show"
  get "students/view"
  get "students/live_search"
  get "students/search"
  get "students/new"
  post "students/create"


  get "users/login"
  post "users/login"

  get "home/index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  root :to => "home#index"
end
