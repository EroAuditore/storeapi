class Api::V1::SalesController < ApplicationController
    def index
        @sale = Sale.all
       
        render json: {
            data: @sale,
            status: 200,
            message: "All Sales"
          }, status: :ok
    end

    def create
       
        @sale = Sale.new(sale_new)
        statuses = []
        if @sale.save
           
        params[:ticket].each do |product|
          
            product_p =product_params(product)
            @ticket_new = @sale.tickets.new(product_p)
            statuses << ( @ticket_new.save ? "OK" : @ticket_new.errors.full_messages )
        end
       

        render json: {
            data: @sale,
            message: 'Sale succesfully created.'
        }, status: :created
        else
        render json: {
            data: [],
            message: format_errors
        }, status: :not_acceptable
        end
    end

    def sales_today

        sales_day = Sale.sales_today
        render json: {
            data: sales_day,
            status: 200,
            message: "Sales of the day"
          }, status: :ok

    end

    def sales_week
        byebug
        sales_week = Sale.sales_week
     
        render json: {
            data: sales_week,
            status: 200,
            message: "Sales of the week"
          }, status: :ok

    end

    def sales_month
        byebug
        sales_month = Sale.sales_month
        byebug
        render json: {
            data: sales_month,
            status: 200,
            message: "Sales of the month"
          }, status: :ok

    end

    private
    def sale_new
        params.require(:sale).permit(:total, :date, :credit)
    end
     
    def product_params( product )        
        product.permit(:_id, :total, :description, :credit)
    end
    
end