module Universal
  module Models
    module DocumentNumber
      extend ActiveSupport::Concern
      
      included do
        include Mongoid::Document
        include Universal::Concerns::Kind

        store_in collection: 'document_numbers'

        #field :t, as: :type
        field :n, as: :number, type: Integer
        field :p, as: :prefix
        field :s, as: :scope
        
        validates :kind, presence: true
        
        index _kn: 1
      end
    
      module ClassMethods
        
        #return the current next invoice number, and increment the model for the next upcoming invoice
        def generate!(kind, prefix=nil, scope=nil)
          #find the matching number
          prefix ||= kind[0,1].upcase
          number = ::Universal::DocumentNumber.find_by(kind: kind, prefix: prefix, scope: scope)
          if number.nil?
            next_num = 1
            ::Universal::DocumentNumber.create(kind: kind.to_s, prefix: prefix, number: 2, scope: scope)
          else
            next_num = number.number
            number.inc(number: 1)
          end
          logger.debug "next_num"
          return "#{prefix.nil? ? '' : prefix.upcase}-#{next_num.to_s.rjust(8,'0')}"
        end
      end
    end
  end
