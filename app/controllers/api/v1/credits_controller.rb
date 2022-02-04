class Api::V1::CreditsController < ApplicationController
    include SalesHelper
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
                #last credit is paid 
                render json: {
                    data: [{client_id: params[:id], paid:false, total:0}],
                    message: 'Credit empty paid'
                }, status: :ok

            end
        else
            
        render json: {
            data: [{client_id: params[:id], paid:false, total:0}],
            message: 'Credit empty'
        }, status: :ok
        end
    end
    


    def add_to_credit
      
        credit = Credit.client_credit(params[:client_id]).first
       
        unless (credit.nil?)
            
           #client already has credit
            if ( (!credit.paid.nil?)  && (credit.paid == false))
            
                save_sale(sale_new, params[:ticket], credit.id)
                credit.total = params[:total]
                credit.save
                render json: {
                data:credit,
                    message: 'Added to client credit.'
                }, status: :ok
            elsif (credit.paid == true)
                #last credit is paid creates a new credit
            
                newCredit = Credit.new(credit_params)
                
                if newCredit.save
                    
                    save_sale(sale_new, params[:ticket], newCredit.id)
                    
                    render json: {
                        data: [newCredit],
                        message: 'New credit created'
                    }, status: :ok
                end

            end
        else
        #Create new credit when client is new
       
        newCredit = Credit.new(credit_params)
      
            if newCredit.save
                
                save_sale(sale_new, params[:ticket], newCredit.id)
                render json: {
                    data: [newCredit],
                    message: 'New credit created'
                }, status: :ok
            end
            
        end
    end


    private

    def credit_params
        params.permit(:client_id, :total)
    end
    def sale_new
       
        params.require(:sale).permit(:total, :date, :credit)
    end
     
   
end
