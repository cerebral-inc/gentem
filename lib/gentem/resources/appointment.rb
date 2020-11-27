module Gentem
  module Resources
    class Appointment < RestfulResource
      public :list, :list_all, :create, :read, :replace, :update, :destroy
    end
  end
end
