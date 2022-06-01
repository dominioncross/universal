module Universal
  module Models
    module AutoFlag
      extend ActiveSupport::Concern
      
      included do
        include Mongoid::Document
        include Universal::Concerns::Archivable
        include Universal::Concerns::Polymorphic
        include Universal::Concerns::Kind

        store_in collection: 'auto_flags'

        field :flag
        field :date, type: Date
        field :parent_type
        field :parent_id
        field :child_subject_type #If a child subject type is set, update the flags of the children, not this subject
        
        kinds %w(add remove)
        
        attr_accessor :date_from, :date_to
        
        scope :today, ->(){where(date: Date.today)}
        default_scope ->(){order_by(date: :asc)}
        default_scope ->(){where(:date.gte => Date.today)}
        
        validates :flag, :date, :subject_type, :subject_id, presence: true
        
        def parent
          return nil if self.parent_type.blank? or self.parent_id.blank?
          self.parent_type.classify.constantize.unscoped.find self.parent_id
        end
        
        def subject_model
          if self.parent.nil?
            self.subject_type.classify.constantize.unscoped.find self.subject_id
          else
            ::Universal::AutoFlag.find_embedded_document(self.parent, self.subject_type, self.subject_id)
          end
        end
        
      end
      
      module ClassMethods
        def find_embedded_document(parent, subject_type, subject_id)
          if subject_type == 'Lobby::Room'
            return parent.rooms.find(subject_id)
          end
        end
      end
      
    end
  end
