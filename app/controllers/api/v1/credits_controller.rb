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
      
        credit = Credit.client_credit(params[:client_id]).last
       
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

    def credit_detail
       
        last_credit = Credit.client_credit_unpaid(params[:client_id]).last
      
        if !last_credit.nil?
            
            t =Credit.includes(:tickets).where("credits.id = ?", last_credit.id)
           
             
            render json: {
                tickets: t[0].tickets,
                credit: last_credit,
                message: 'Tickets'
            }, status: :ok
        else
          
            render json: {
                tickets: [],
                credit: { total: 0},
                message: 'Credito vacio'
            }, status: :ok

        end
        
        
    end

    def close_credit
        
    end
    


    private

    def credit_params
        params.permit(:client_id, :total)
    end
    def sale_new
       
        params.require(:sale).permit(:total, :date, :credit)
    end

    def save_sale(sale_new, tickets, credit_id= nil)
        
        @sale = Sale.new(sale_new)
        @sale.credit_id = credit_id
        statuses = []
        if @sale.save
         
            tickets.each do |product|
                product_p =product_params(product)
                @ticket_new = @sale.tickets.new(product_p)
                statuses << ( @ticket_new.save ? "OK" : @ticket_new.errors.full_messages )
            end
        end
    end

   
     
    def product_params( product )
       
        product.permit(:_id, :total, :description)
    end
     
   
end
