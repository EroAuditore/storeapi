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
end
