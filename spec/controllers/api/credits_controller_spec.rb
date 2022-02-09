require 'rails_helper'

describe 'Client API', type: :request do

    context 'When fetching credits' do
        let!(:credit) do
            FactoryBot.create(:credit)
        end

        let!(:credit_paid) do
            FactoryBot.create(:paid_credit)
        end
        let!(:cliente_test2) do
            FactoryBot.create(:client, name: "cliente test 2")
        end
       
        it 'Returns the last credit by client' do
            
            get "/api/v1/credit/client/#{credit.client_id}"
            json = JSON.parse(response.body)
            expect(json['data']).to have_attributes(count: be_positive)
        end
        it 'Returns the last unpaid credit' do
         
            get "/api/v1/credit/client/#{credit.client_id}"
            json = JSON.parse(response.body)
          
            credit_test = json['data']
            expect(credit_test).to include('paid')
            expect(credit_test["paid"]).to be false
        end
        it 'Returns the Empty credit when is new client' do
            
            
            get "/api/v1/credit/client/#{cliente_test2.id}"
            json = JSON.parse(response.body)
          
            credit_test = json['data']
            
            expect(credit_test).to include('paid')
            expect(credit_test["paid"]).to be false

            expect(credit_test).to include('client_id')
            expect(credit_test["client_id"].to_i).to eq cliente_test2.id

            expect(credit_test).to include('total')
            expect(credit_test["total"]).to eq 0
        end
        it 'Returns the Empty credit if the last credit is paid' do
          
            get "/api/v1/credit/client/#{credit_paid.client_id}"
            
            json = JSON.parse(response.body)
            credit_test = json['data']
            
            expect(json['data']).to have_attributes(count: be_positive)

            expect(credit_test).to include('paid')
            expect(credit_test["paid"]).to be false

            expect(credit_test).to include('client_id')
            expect(credit_test["client_id"].to_i).to eq credit_paid.client_id

            expect(credit_test).to include('total')
            expect(credit_test["total"]).to eq 0
        end


        it 'returns the ticktes from user' do
            
            client_credit = FactoryBot.create(:client)
            
            credit_test = FactoryBot.create(:credit, client_id: client_credit.id)
           
            sale_test = FactoryBot.create(:sale, credit_id: client_credit.id)
           
            ticket = FactoryBot.create(:ticket, sale_id: sale_test.id)
            tickets_test = FactoryBot.create_list(:ticket, 5, sale: sale_test)
           
            get "/api/v1/credit/tickets/#{client_credit.id}"
            json = JSON.parse(response.body)
            
            expect(json['message']).to eq 'Tickets'
            
            # expect(json['data']).to have_attributes(count: be_positive)
        end
    end

    context 'When Add sales to credit' do

        let!(:client_credit) do
            FactoryBot.create(:client)
        end
        let!(:product_bot) do
            FactoryBot.create_list(:product, 5)
        end
        let!(:products) {JSON.parse(product_bot.to_json)}
        let(:sale) {{ total:10.29 , date: '2022/01/07', credit: true}}
        let!(:venta) {{ sale: sale, ticket: products}}
        let(:product_list) { products.each do |prod|
            prod["_id"] = prod["id"]
        end}

        
        it 'Creates a new credit when client dont have one' do

            
            post "/api/v1/credit/client/add", params: { total: 250, client_id: client_credit.id,  sale: sale, ticket: product_list }
            json = JSON.parse(response.body)

            expect(json['data']).to have_attributes(count: be_positive)
            expect(json['message']).to eq 'New credit created'
            expect(Credit.count).to eq 1
            expect(Sale.count).to eq 1
            expect(Ticket.count).to eq 5
        end
        it 'Creates a new credit when the last is paid' do
            FactoryBot.create(:paid_credit, client_id: client_credit.id)

            post "/api/v1/credit/client/add", params: { total: 250, client_id: client_credit.id,  sale: sale, ticket: product_list }
            json = JSON.parse(response.body)
            expect(json['data']).to have_attributes(count: be_positive)
            expect(json['message']).to eq 'New credit created'
             expect(Credit.count).to eq 2
             expect(Sale.count).to eq 1
            expect(Ticket.count).to eq 5

        end
        it 'Adds to credit when the last is unpaid' do
            FactoryBot.create(:credit, client_id: client_credit.id)

            post "/api/v1/credit/client/add", params: { total: 250, client_id: client_credit.id,  sale: sale, ticket: product_list }
            json = JSON.parse(response.body)
            expect(json['data']).to have_attributes(count: be_positive)
            expect(json['message']).to eq 'Added to client credit.'
             expect(Credit.count).to eq 1
             expect(Sale.count).to eq 1
            expect(Ticket.count).to eq 5
        end
    end

    context 'When close credit' do
        let!(:client_credit) do
            FactoryBot.create(:credit)
        end
        it "update credit as paid true" do
            put "/api/v1/credit/close", params: { id: client_credit.id }
            json = JSON.parse(response.body)
           
            expect(json['credit']).to have_attributes(count: be_positive)
            expect(json['message']).to eq 'Credit closed succesfully.'
        end
        
    end

end