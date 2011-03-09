Stats::Application.routes.draw do
  match '/add_page_view' => 'tracking#add_page_view'
  match '/admin' => 'admin#index'
  match '/report/:id/:key' => 'reports#index', :as => :dashboard
  match '/test_report/:id' => 'reports#test_index'
  match '/report/:id/:key/article_views.csv' => 'reports#article_views_csv', :as => :article_view_csv
  match '/report/:id/:key/weekly_page_view_graph/' => 'reports#weekly_page_view_graph'
  match '/report/:id/:key/monthly_page_view_graph/' => 'reports#monthly_page_view_graph'
  match '/report/:id/:key/twelve_week_page_view_graph/' => 'reports#twelve_week_page_view_graph'
  match '/report/:id/:key/page_view_sparkline.gif' => 'reports#page_view_sparkline'
  match '/report/:id/:key/update_total_page_views.js' => 'reports#update_total_page_views'
  
end