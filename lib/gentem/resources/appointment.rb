module Gentem
  module Resources
    class Appointment < RestfulResource
      public :list, :create, :read, :update, :partial_update, :destroy
    end
  end
end
