Rails.application.routes.draw do
  
  resources 'stats'
  root 'stats#index'
  post 'post/:mac' => 'sensor#receive'
end
