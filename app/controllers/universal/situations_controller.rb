require_dependency 'universal/application_controller'

module Universal
  class SituationsController < Universal::ApplicationController
    before_action :find_subject, except: %i[destroy]
    before_action :find_scope, except: %i[destroy]

    def create
      if @subject and @scope
        @subject.situations.create scope: @scope,
                                   notes: (params[:situation].blank? ? params[:notes] : params[:situation][:notes]),
                                   context: params[:context]
      end
      respond_to do |format|
        format.json do
          render json: {}
        end
        format.js do
          render layout: false
        end
      end
    end

    def destroy
      @sit = Universal::Situation.find(params[:id])
      @sit&.destroy

      render layout: false
    end

    private

    def find_subject
      return unless !params[:subject_type].blank? and !params[:subject_id].blank?

      @subject = params[:subject_type].classify.constantize.find(params[:subject_id])
    end

    def find_scope
      return unless !params[:scope_type].blank? and !params[:scope_id].blank?

      @scope = params[:scope_type].classify.constantize.find(params[:scope_id])
    end
  end
end
