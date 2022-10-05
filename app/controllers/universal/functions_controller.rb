require_dependency "universal/application_controller"

module Universal
  class FunctionsController < Universal::ApplicationController

    def create
      @model = embedder
      @model.set_function!(params[:function], params[:checked]) if @model
      render plain: ''
    end

    private
    def embedder
      if !params[:model_class].blank?
        return params[:model_class].classify.constantize.find params[:model_id]
      end
      return nil
    end

  end

end
