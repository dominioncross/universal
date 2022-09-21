require_dependency "universal/application_controller"

module Universal
  class SituationsController < Universal::ApplicationController
    
    before_action :find_subject
    before_action :find_scope
    
    def create
      if @subject and @scope
        @subject.situations.create scope: @scope, notes: (params[:situation].blank? ? params[:notes] : params[:situation][:notes])
      end
      respond_to do |format|
        format.json{
          render json: {}
        }
        format.js{
          render layout: false
        }
      end
    end
    
    private
    def find_subject
      if !params[:subject_type].blank? and !params[:subject_id].blank?
        @subject = params[:subject_type].classify.constantize.find(params[:subject_id])
      end
    end
    def find_scope
      if !params[:scope_type].blank? and !params[:scope_id].blank?
        @scope = params[:scope_type].classify.constantize.find(params[:scope_id])
      end
    end
    
  end
end