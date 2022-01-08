class Api::V1::SalesController < ApplicationController
    def index
        @sale = Sale.all
        # render json: @products
        render json: {
            data: @sale,
            status: 200,
            message: "All Sales"
          }, status: :ok
    end

    def create
        @sale = Sale.new(sale_new)
        if @sale.save
        render json: {
            data: @sale,
            message: 'sale succesfully created.'
        }, status: :created
        else
        render json: {
            data: [],
            message: format_errors
        }, status: :not_acceptable
        end
    end

    def sale_new
            
        params.require(:sale).permit(:total, :date, :credit)
    end
end