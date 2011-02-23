Stats::Application.routes.draw do
  match '/add_page_view' => 'tracking#add_page_view'
end
