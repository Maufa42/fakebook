class LikesController < ApplicationControl
    def create
        @like = current_user.like.new(like_params)

        if !@like.save
            flash[:notice] =  @like.errors.full_messages.to_sentence
        end

        redirect_to @like.post
    end

    def destroy
        @like = current_user.likes.find(params[:id])
        post = @like.post
        @like.destroy
        redirect_to post
    end

    private
    def like_params
        params.require(:like).permit(:post_id)
    end

end