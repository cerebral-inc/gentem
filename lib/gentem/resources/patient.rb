module Gentem
  module Resources
    class Patient < RestfulResource
      public :list, :create, :read, :update, :partial_update
    end
  end
end