module Universal
  module Models
    module Situation
      extend ActiveSupport::Concern

      included do
        include Mongoid::Document
        include Mongoid::Timestamps
        include Universal::Concerns::Polymorphic
        include Universal::Concerns::Scoped
        include Universal::Concerns::Status

        store_in collection: 'universal_situations'

        field :n, as: :notes
        field :ea, as: :expires_at, type: DateTime
        
        default_scope ->(){where(status: :current, :expires_at.gte => Time.zone.now)}
        default_scope ->(){order_by(created_at: :desc)}
        
        statuses %w(current expired), default: :current
        
        before_create :set_expiry
        before_create :expire_previous
        
        private
        def expire_previous
          prev = self.subject.situations.where(scope: self.scope).first
          prev.expired! if !prev.nil?
        end
        def set_expiry
          self.expires_at = 24.hours.from_now
        end
        
      end

    end
  end
