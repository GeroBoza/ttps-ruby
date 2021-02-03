Rails.application.routes.draw do
    root to: "home#index"
    devise_for :users, :controllers => {:registrations => "registrations"}
    
    resources :users do
        get "export_all_notes"
        resources :books do
            get "export_book_notes"
            resources :notes do
                get "export"
            end
        end
    end
    
     
end
