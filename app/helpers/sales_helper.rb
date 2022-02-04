module SalesHelper
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