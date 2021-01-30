Rails.application.routes.draw do
    root to: "home#index"
    devise_for :users 
    
    resources :users do
        resources :books do
            resources :notes do
                get "export"
            end
        end
    end
    
     
end
