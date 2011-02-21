Stats::Application.routes.draw do
  match 'pageview' => 'page_views#create'
  match 'report/:id' => 'page_views#show'
  
  match '/:id' => 'members#index'

end
