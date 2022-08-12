class CommentsController < ApplicationController


    def new
        @comment = Comment.new
    end

    def create
                @comment = current_user.comment.create(comment_params)
                @post = Post.find(params[:comment][:post_id])
                if @comment.save
                    redirect_to root_path
                else
                    render 'new'
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
        params.require(:comment).permit(:content,:post_id)
    end

end