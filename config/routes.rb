Stats::Application.routes.draw do
  match 'pageview' => 'page_views#create'
  match 'report/:id' => 'page_views#show'
  
  match 'generate_article_view/:article_id' => 'page_views#generate_article_view'
  
  root :to => 'page_views#index'
end
