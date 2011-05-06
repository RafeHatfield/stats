Stats::Application.routes.draw do
  match '/add_page_view' => 'tracking#add_page_view'
  
  match '/admin' => 'admin#index'
  
  # article dashboard
  match '/article_test/:writer_id/:article_id' => 'reports#test_article_dashboard'
  
  match '/article_report/:key/:article_id' => 'reports#article_dashboard', :as => :article_dashboard
  match '/report/:key/article_views.csv' => 'reports#article_views_csv', :as => :article_view_csv
  match '/article_stats/:key' => 'article_stats#index', :as => :article_stats
  match '/keyphrases_for_article/:key/:article_id' => 'keyphrases#for_article', :as => :keyphrases_for_article
  match '/keyphrases_for_writer/:key/:writer_id' => 'keyphrases#for_writer', :as => :keyphrases_for_writer
  match '/writer_domains/:key/:writer_id' => 'domains#for_writer', :as => :writer_domains
  match '/article_domains/:key/:article_id' => 'domains#for_article', :as => :article_domains
  match '/writer_sources/:key/:writer_id' => 'sources#for_writer', :as => :writer_sources
  match '/article_sources/:key/:article_id' => 'sources#for_article', :as => :article_sources
    
  # dashboard
  match '/test/:writer_id' => 'reports#test_dashboard'
  
  match '/report/:key' => 'reports#dashboard', :as => :dashboard
  
  # My suite graphs and data.
  match '/report/:key/weekly_page_view_graph/' => 'mysuite_integration#weekly_page_view_graph'
  match '/report/:key/monthly_page_view_graph/' => 'mysuite_integration#monthly_page_view_graph'
  match '/report/:key/twelve_week_page_view_graph/' => 'mysuite_integration#twelve_week_page_view_graph'
  match '/report/:key/page_view_sparkline.gif' => 'mysuite_integration#page_view_sparkline'
  match '/report/:key/update_total_page_views.js' => 'mysuite_integration#update_total_page_views'
  
end