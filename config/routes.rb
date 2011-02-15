Stats::Application.routes.draw do
  match 'pageview' => "page_views#create"
  root :to => 'page_views#index'
end
