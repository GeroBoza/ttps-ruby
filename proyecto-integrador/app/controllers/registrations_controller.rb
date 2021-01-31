class RegistrationsController < Devise::RegistrationsController
    def create
      super
      current_user.books.create(user_id: current_user.id,name:"Global Book")
    end
end 