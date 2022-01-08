
require 'rails_helper'

describe 'Sells API', type: :request do
    # let!(:sell_test) do
    #     FactoryBot.create(:Sale, date: '2022/01/07', credit: false, total:10_29)
    # end
    
    it 'adds a new Sell successfully' do
        post '/api/v1/sales/new', params: { Sale:{ total:10_29 , date: '2022/01/07', credit: false} }
        json = JSON.parse(response.body)
        expect(json['message']).to eql('Sale succesfully created.')
    end

   
end