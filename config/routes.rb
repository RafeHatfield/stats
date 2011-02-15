Stats::Application.routes.draw do
  match 'pageview' => "page_views#create"
end
