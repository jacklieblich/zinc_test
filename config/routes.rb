Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'macbeth_analyzers#new'
  post '/count', to: 'macbeth_analyzers#count'
end
