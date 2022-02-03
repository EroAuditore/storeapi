require 'rails_helper'

describe 'Client API', type: :request do

    context 'When fetching credits' do
        let(:credit) do
            FactoryBot.create(:credit)
        end

        let!(:credit_paid) do
            FactoryBot.create(:paid_credit)
        end

        it 'Returns the last credit by client' do
            
            get "/api/v1/credit/client/#{credit.client_id}"
            json = JSON.parse(response.body)
            expect(json['data']).to have_attributes(count: be_positive)
        end
        it 'Returns the last unpaid credit' do
            get "/api/v1/credit/client/#{credit.client_id}"
            json = JSON.parse(response.body)
            credit_test = json['data'][0]
            expect(credit_test).to include('paid')
            expect(credit_test["paid"]).to be false
        end
        it 'Returns the Empty credit when is new client' do
          
            get "/api/v1/credit/client/16"
            json = JSON.parse(response.body)
           
            credit_test = json['data'][0]
            
            expect(credit_test).to include('paid')
            expect(credit_test["paid"]).to be false

            expect(credit_test).to include('client_id')
            expect(credit_test["client_id"]).to eq "16"

            expect(credit_test).to include('total')
            expect(credit_test["total"]).to eq 0
        end
        it 'Returns the Empty credit if the last credit is paid' do
            
          
            get "/api/v1/credit/client/#{credit_paid.client_id}"
            
            json = JSON.parse(response.body)
            credit_test = json['data'][0]
            
            expect(json['data']).to have_attributes(count: be_positive)

            expect(credit_test).to include('paid')
            expect(credit_test["paid"]).to be false

            expect(credit_test).to include('client_id')
            expect(credit_test["client_id"].to_i).to eq credit_paid.client_id

            expect(credit_test).to include('total')
            expect(credit_test["total"]).to eq 0
        end
    end

    context 'When Add sales' do
        it 'Creates a new credit when client dont have one' do
        end
        it 'Creates a new credit when the last is paid' do
        end
        it 'Creates adds credit when the last is paid' do
        end
    end


end