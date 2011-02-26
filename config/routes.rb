Stats::Application.routes.draw do
  match '/add_page_view' => 'tracking#add_page_view'
  match '/admin' => 'admin#index'
  
  match '/report/:id/:key' => 'reports#index', :as => :dashboard
  match '/test_report/:id' => 'reports#test_index'
end
