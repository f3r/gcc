class TransactionsController < PrivateController
  respond_to :js

  def update
    @transaction = Transaction.find(params[:id])

    if @transaction.change_state!(params[:event])
      respond_to do |format|
        format.js { render :layout => false, :template => "transactions/change_state" }
      end
    else
      respond_to do |format|
        format.js { render :layout => false, :template => "transactions/error_message" }
      end
    end
  end
end
