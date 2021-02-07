class RegistrationsController < Devise::RegistrationsController
    def create
      super
      if current_user
        current_user.books.create(user_id: current_user.id,name:"Global Book")
      end
    end
end 