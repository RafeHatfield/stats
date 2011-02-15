Stats::Application.routes.draw do
  match 'pageview' => 'page_views#create'
  match 'report/:id' => 'page_view#show'
  root :to => 'page_views#index'
end
