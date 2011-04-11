Stats::Application.routes.draw do
  match '/add_page_view' => 'tracking#add_page_view'
  
  match '/admin' => 'admin#index'
  
  # article dashboard
  match '/article_test/:writer_id/:article_id' => 'reports#test_article_dashboard'
  
  match '/article_report/:key/:article_id' => 'reports#article_dashboard', :as => :article_dashboard
  match '/report/:key/article_views.csv' => 'reports#article_views_csv', :as => :article_view_csv
  match '/article_stats/:key' => 'article_stats#index', :as => :article_stats
  match '/keyphrases/:key/:article_id' => 'keyphrases#index', :as => :keyphrases
    
  # dashboard
  match '/test/:writer_id' => 'reports#test_dashboard'
  
  match '/report/:key' => 'reports#dashboard', :as => :dashboard
  
  # My suite graphs and data.
  match '/report/:id/:key/weekly_page_view_graph/' => 'reports#weekly_page_view_graph'
  match '/report/:id/:key/monthly_page_view_graph/' => 'reports#monthly_page_view_graph'
  match '/report/:id/:key/twelve_week_page_view_graph/' => 'reports#twelve_week_page_view_graph'
  match '/report/:id/:key/page_view_sparkline.gif' => 'reports#page_view_sparkline'
  match '/report/:id/:key/update_total_page_views.js' => 'reports#update_total_page_views'
  
  match ':controller(/:action(/:id(.:format)))'
end