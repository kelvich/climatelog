Rails.application.routes.draw do
  root 'stats#index'

  post 'post/:mac' => 'sensor#receive'

end
