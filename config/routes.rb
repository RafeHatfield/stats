Stats::Application.routes.draw do
  match 'pageview' => "page_views#create"
  resources :pageviews, :only => [:index, :show]
  root :to => 'page_views#index'
end
