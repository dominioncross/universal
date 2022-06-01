module Universal
  module Models
    module Country
      extend ActiveSupport::Concern
      
      included do
        include Mongoid::Document

        store_in collection: Universal::Configuration.country_collection

        field :code
        field :code_3
        field :name
        field :capital
        field :telephone_code
        field :iso_number

        validates :code, :name, presence: true
        
        default_scope ->{order_by(name: :asc)}
        
        def to_json
          return {
            id: self.id.to_s,
            code: self.code,
            code_3: self.code_3,
            name: self.name,
            capital: self.capital,
            telephone_code: self.telephone_code,
            iso_number: self.iso_number
          }  
        end
        
      end
    end
  end
