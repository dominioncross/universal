module Universal
  module Concerns
    module Trashable
      extend ActiveSupport::Concern

      included do
        field :_trs, as: :trashed, type: Mongoid::Boolean, default: false

        default_scope ->(){where(trashed: false)}
        scope :trashed, ->(){where(trashed: true)}
        scope :not_trashed, ->(){where(trashed: false)}
      end

      def trash!
        self.set(_trs: true)
      end
      def untrash!
        self.set(_trs: false)
      end

    end
  end
end
