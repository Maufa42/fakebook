class CommentsController < ApplicationController
    

    def new
        @comment = Comment.new
    end

    def create
                @post = Post.find(params[:post_id])
                @comment = @post.comments.create!(comment_params)
                debugger
                if @comment.save
                    redirect_to all_user_path
                else
                    redirect_to root_path
                end
            end

    def destroy
        @comment = Comment.find[params[:id]]
        return unless current_user.id == @comment.user_id

        @comment.destroy
        flash[:notice] = 'Comment deleted'
        redirect_to root_path
   
    end

    private

    def comment_params
        params.require(:comment).permit(:content,:user_id)
    end

end