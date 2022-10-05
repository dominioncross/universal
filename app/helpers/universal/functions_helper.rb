module Universal
  module FunctionsHelper

    def easy_functions(model)
      keys = UNIVERSAL_FUNCTIONS[model.class.name.demodulize.to_s.downcase.to_sym]
      if model.nil?
        render plain: 'Functions not initiated'
      else
        render partial: '/universal/functions/list', locals: {model: model, :keys => keys}
      end
    end
    
  end
end
