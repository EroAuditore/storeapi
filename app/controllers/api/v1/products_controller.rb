class Api::V1::ProductsController < ApplicationController
    def index
        @products = Product.all
        # render json: @products
        render json: {
            data: @products,
            status: 200,
            message: "logged out successfully"
          }, status: :ok
    end

    def create
        @product = Product.new(product_new)
        if @product.save
        render json: {
            data: @product,
            message: 'product succesfully created.'
        }, status: :created
        else
        render json: {
            data: [],
            message: format_errors
        }, status: :not_acceptable
        end
        
    end

    def update
      
        @product = begin
            Product.find(params[:id])
          rescue StandardError
            nil
          end
          
          if @product.update(product_params)
            render json: {
                data: @product,
                message: 'product succesfully updated.'
            }, status: :accepted
            else
            render json: {
                data: [],
                message: format_errors
            }, status: :not_acceptable
            end
        
    end

    private
    def product_params
        params.require(:product).permit!  
        #params.permit(:description, :code, :sale_price, :purchase_price, :bulk_price, :bulk, :id)
    end

    def product_new
        params.require(:product).permit(:description, :code, :sale_price, :purchase_price, :bulk_price, :bulk)
    end
end
