module Universal
  module Models
    module KeyValue
      extend ActiveSupport::Concern

      included do
        include Mongoid::Document

        field :c, as: :context
        field :k, as: :key
        field :n, as: :name
        field :v, as: :value
        
        embedded_in :model
      end
    end
  end
end
