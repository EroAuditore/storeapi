class Api::V1::SellsController < ApplicationController
    def index
        @sell = Sell.all
        # render json: @products
        render json: {
            data: @sell,
            status: 200,
            message: "All Sells"
          }, status: :ok
    end

    def create
        @sell = Sell.new(sell_new)
        if @sell.save
        render json: {
            data: @sell,
            message: 'Sell succesfully created.'
        }, status: :created
        else
        render json: {
            data: [],
            message: format_errors
        }, status: :not_acceptable
        end
    end

    def sell_new
            
        params.require(:sell).permit(:total, :date, :credit)
    end
end