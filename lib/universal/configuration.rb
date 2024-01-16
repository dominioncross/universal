module Universal
  class Configuration
    DEFAULT_TEMPLATE_ENGINE  = :bootstrap
    DEFAULT_ICON_ENGINE      = :fontawesome

    cattr_accessor :template_engine, :icon_engine, :field_name_status, :user_scoped, :field_name_taggable,
                   :field_name_tokened, :field_name_email_history, :numbered_scope_field,
                   :class_name_user, :class_name_auto_flag, :country_collection, :user_scope_field,
                   :user_group_collection, :scoped_user_groups

    def self.reset
      self.template_engine   = DEFAULT_TEMPLATE_ENGINE
      self.icon_engine       = DEFAULT_ICON_ENGINE
      self.field_name_status = :_s
      self.field_name_taggable = :tags
      self.field_name_tokened = :_t
      self.field_name_email_history = :_eh
      self.class_name_user = nil
      self.user_scoped          = false
      self.country_collection = 'universal_countries'
      self.user_scope_field     = nil
      self.class_name_auto_flag = 'Universal::AutoFlag'
      self.numbered_scope_field = nil
      self.user_group_collection = 'universal_access_user_groups'
      self.scoped_user_groups = false
    end
  end
end

Universal::Configuration.reset
