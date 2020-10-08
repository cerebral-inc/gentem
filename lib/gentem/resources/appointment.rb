module Gentem
  module Resources
    class Appointment < RestfulResource
      public :list, :create, :read, :replace, :update, :destroy
    end
  end
end
