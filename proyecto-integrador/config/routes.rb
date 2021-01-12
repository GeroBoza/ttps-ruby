Rails.application.routes.draw do
    root to: "home#index"
    devise_for :users 
    
    resources :users do
        resources :books do
            resources :notes
        end
    end
    
     
end
