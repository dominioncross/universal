require_dependency "universal/application_controller"

module Universal
  class ConfigurablesController < Universal::ApplicationController
    before_action :find_model

    def create
      @model.set_config!(params[:key], params[:value].encode('UTF-16le', invalid: :replace, replace: '').encode('UTF-8'), nil, params[:name]) if @model
      xhr?
    end

    def delete
      key_value = @model.key_values.find_by(key: params[:key])
      key_value.destroy if !key_value.nil?
      xhr?
    end

    private
    def find_model
      if !params[:model_class].blank? and !params[:model_id].blank?
        @model = params[:model_class].classify.constantize.where(id: params[:model_id]).first
      end
    end
  end
end
