Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'save-order' => 'email#save_order'
  post 'save-order-test' => 'email#save_order_test'

end
