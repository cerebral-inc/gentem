module Gentem
  module Resources
    class Patient < RestfulResource
      public :list, :create, :read, :replace, :update
    end
  end
end
