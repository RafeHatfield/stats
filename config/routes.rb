Stats::Application.routes.draw do
  
  # Tracking
  match '/add_page_view' => 'tracking#add_page_view'
  
  # Admin
  match '/admin' => 'admin#index'
  
  # Dashboards
  match '/report/:key' => 'reports#dashboard', :as => :dashboard
  match '/article_report/:key/:article_id' => 'reports#article_dashboard', :as => :article_dashboard
  match '/test/:writer_id' => 'reports#test_dashboard'

  # CSV
  match '/report/:key/article_views.csv' => 'reports#article_views_csv', :as => :article_view_csv
  
  # Keyphrases
  match '/article_keyphrases/:key/:article_id' => 'keyphrases#for_article', :as => :article_keyphrases
  match '/writer_keyphrases/:key/:writer_id' => 'keyphrases#for_writer', :as => :writer_keyphrases
  
  # Domains
  match '/writer_domains/:key/:writer_id' => 'domains#for_writer', :as => :writer_domains
  match '/article_domains/:key/:article_id' => 'domains#for_article', :as => :article_domains
  
  # Sources
  match '/writer_sources/:key/:writer_id' => 'sources#for_writer', :as => :writer_sources
  match '/article_sources/:key/:article_id' => 'sources#for_article', :as => :article_sources
    
  # Articles
  match '/writer_articles/:key/:writer_id' => 'articles#for_writer', :as => :writer_articles

  # My suite graphs and data.
  match '/report/:key/weekly_page_view_graph/' => 'mysuite_integration#weekly_page_view_graph'
  match '/report/:key/monthly_page_view_graph/' => 'mysuite_integration#monthly_page_view_graph'
  match '/report/:key/twelve_week_page_view_graph/' => 'mysuite_integration#twelve_week_page_view_graph'
  match '/report/:key/page_view_sparkline.gif' => 'mysuite_integration#page_view_sparkline'
  match '/report/:key/update_total_page_views.js' => 'mysuite_integration#update_total_page_views'
  
end