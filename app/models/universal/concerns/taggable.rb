module Universal
  module Concerns
    module Taggable
      extend ActiveSupport::Concern

      included do
        include Mongoid::Search

        field Universal::Configuration.field_name_taggable, as: :tags, type: Array, default: []

        search_in Universal::Configuration.field_name_taggable

        scope :tagged_with, ->(tag) { where(tags: /\b#{tag}\b/i) }

        def tagged_with?(tag)
          (!tags.nil? and tags.map { |t| t.downcase }.include?(tag.downcase.to_s))
        end

        def tag!(tag)
          return if tagged_with?(tag)

          push(Universal::Configuration.field_name_taggable => tag.to_s.downcase)
          save # to update the keywords
        end

        def remove_tag!(tag)
          pull(Universal::Configuration.field_name_taggable => tag.to_s.downcase)
        end
      end
    end
  end
end
