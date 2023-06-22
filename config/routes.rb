Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :customers
  resources :products
  resources :tax_rates 
  resources :orders do
    resources :payments
    resources :discounts
  end
end
