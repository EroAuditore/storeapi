class Api::V1::CreditsController < ApplicationController

    def index
        @credits = Credit.all
        
        render json: {
            data: @credits,
            status: 200,
            message: "Credit all"
          }, status: :ok
        
    end

    def credit_client
       
        credit = Credit.client_credit(params[:id])
        
        unless (credit.empty?)
            if ( (!credit.pluck(:paid)[0].nil?)  && (credit.pluck(:paid)[0] == false))
                render json: {
                data:credit,
                    message: 'Client credit.'
                }, status: :ok
            elsif (credit.pluck(:paid)[0] == true)
                render json: {
                    data: [{client_id: params[:id], paid:false, total:0}],
                    message: 'Credit empty paid'
                }, status: :not_found

            end
        else
            
        render json: {
            data: [{client_id: params[:id], paid:false, total:0}],
            message: 'Credit empty'
        }, status: :not_found
        end
    end
    


    def add_to_credit
        byebug
        @credit = Credit.client_credit(params[:id])
        byebug
        unless @credit.empty?
            #if it has already a credit
            render json: {
               data:@credit,
                message: 'Client credit.'
            }, status: :ok
            else
            render json: {
                data: {client_id: params[:id], paid:false, total:0},
                message: 'Credit empty'
            }, status: :not_found
            end
        
    end


    private

    def credit_params
        params.require(:credit).permit(:name)
    end
end
