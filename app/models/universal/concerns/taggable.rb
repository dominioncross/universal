module Universal
  module Concerns
    module Taggable
      extend ActiveSupport::Concern

      included do
        include Mongoid::Search

        field Universal::Configuration.field_name_taggable, as: :tags, type: Array, default: []

        search_in Universal::Configuration.field_name_taggable

        scope :tagged_with, ->(tag){where(tags: /\b#{tag.to_s}\b/i)}

        def tagged_with?(tag)
          (!self.tags.nil? and self.tags.map{|t| t.downcase}.include?(tag.downcase.to_s))
        end

        def tag!(tag)
          if !self.tagged_with?(tag)
            self.push(Universal::Configuration.field_name_taggable => tag.to_s)
            self.save #to update the keywords
          end
        end
        def remove_tag!(tag)
          self.pull(Universal::Configuration.field_name_taggable => tag.to_s)
        end

      end

    end
  end
end
