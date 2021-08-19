module Universal
    module ApplicationHelper

      def icon(name, options=nil)
        if Universal::Configuration.template_engine == :bootstrap
          "<i class=\"fa fa-lg fa-fw fa-#{name}\" #{options.nil? ? '' : options}></i>".html_safe
        elsif Universal::Configuration.icon_engine == :fugue
          options ||= {}
          image_tag("icons/fugue/#{name}.png", options.merge(class: "icon"))
        end
      end

      #######COMPONENTS
      def panel(attrs={}, &block)
        render layout: '/universal/components/panel', locals: {attrs: attrs} do
          capture(&block)
        end
      end

      def table(attrs={}, &block)
        render layout: '/universal/components/table', locals: {attrs: attrs} do
          capture(&block)
        end
      end

      def modal(attrs={}, &block)
        render layout: '/universal/components/modal', locals: {attrs: attrs} do
          capture(&block)
        end
      end

      def tabs(attrs={}, &block)
        render layout: '/universal/components/tabs', locals: {attrs: attrs} do
          capture(&block)
        end
      end

    end
  end
