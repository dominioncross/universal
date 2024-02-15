require_dependency 'universal/application_controller'

module Universal
  class CommentsController < Universal::ApplicationController
    before_action :find_model

    def index
      @model = find_model
      render json: @model.comments.map { |c|
                     {
                       id: c.id.to_s,
                       kind: c.kind.to_s,
                       author: (c.user.nil? ? c.author : c.user.name),
                       content: c.content.presence || c.html_body,
                       when: c.when
                     }
                   }
    end

    def create
      @model = find_model
      @comment = @model.comments.new content: params[:content]
      @comment.when = Time.now.utc
      @comment.user = current_user
      if @comment.save
        @model.touch
      else
        logger.debug @comment.errors.to_json
      end
      render json: @model.comments.map { |c|
                     {
                       id: c.id.to_s,
                       author: (c.user.nil? ? c.author : c.user.name),
                       content: c.content.presence || c.html_body,
                       when: c.when
                     }
                   }
    end

    private

    def find_model
      return params[:subject_type].classify.constantize.unscoped.find params[:subject_id] if params[:subject_type]

      nil
    end
  end
end
