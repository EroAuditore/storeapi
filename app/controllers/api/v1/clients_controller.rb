class Api::V1::ClientsController < ApplicationController
    def index
        @clients = Client.all
        
        render json: {
            data: @clients,
            status: 200,
            message: "Client"
          }, status: :ok
        
    end

    def create
        @client = Client.new(client_new)
        if @client.save
        render json: {
            data: @client,
            message: 'Client succesfully created.'
        }, status: :created
        else
        render json: {
            data: [],
            message: format_errors
        }, status: :not_acceptable
        end
            
    end

    def update

        @client = begin
            Client.find(params[:id])
          rescue StandardError
            nil
          end
          
          if @client.update(client_params)
            render json: {
                data: @client,
                message: 'Client succesfully updated.'
            }, status: :accepted
            else
            render json: {
                data: [],
                message: format_errors
            }, status: :not_acceptable
            end
        
    end

    private
    def client_params
        
        params.permit(:name, :activo )
    end

    def client_new
        params.require(:client).permit(:name)
    end
end
