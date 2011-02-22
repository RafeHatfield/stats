Stats::Application.routes.draw do
  match '/:id' => 'members#index'
end
