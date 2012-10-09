class QuestionsController < PrivateController
  before_filter :find_product

  def create
    @comment = current_user.comments.new(params[:comment])
    @comment.product = @product

    if @comment.save
      UserMailer.new_question(@comment.product.user, @comment).deliver if @comment.product
      render '/questions/create', :layout => nil
    else
      render '/questions/validation_error', :layout => nil
    end
  end

  def reply_to_message
    comment_params = params[:comment]
    comment_params[:product_id] = params[:product_id]
    comment_params[:replying_to] = @replying_to = params[:question_id]

    @comment = current_user.comments.new(comment_params)

    if @comment.save
      #Send the mail to the asker 
      UserMailer.new_question_reply(@comment.question.user, @comment).deliver
      respond_to do |format|
        format.js { render :layout => false }
      end
    else
      render :text => 'error'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    @question_id = params[:qId] if params.key?(:qId)

    @type = params[:type]
    
    @comment_params = {'id' => params[:id]}
    
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  private

  def find_product
    @product = Product.find(params[:product_id])
    @owner = @product.user
  end
end
