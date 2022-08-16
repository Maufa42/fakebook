class LikesController < ApplicationController
    def create
        @like = current_user.likes.new(like_params)
        
        # debugger
        # debugger
        if !@like.save
            flash[:notice] =  @like.errors.full_messages.to_sentence
        end

        redirect_to root_path
    end

    def destroy
        @like = current_user.likes.find_by(params[:id])
        post = @like.post
        @like.destroy
        redirect_to post
    end

    private
    def like_params
        params.permit(:post_id)
    end

end