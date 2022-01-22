
require 'rails_helper'

describe 'Sales API', type: :request do
    # let!(:sell_test) do
    #     FactoryBot.create(:Sale, date: '2022/01/07', credit: false, total:10_29)
    # end

    # let!(:sales) {{format: :json, subscription: attrs}}
    let(:product) {{ _id:10 , description: 'product_test1', total:10.29 }}
    let(:products) {[product, product, product]}
    let(:sale) {{ total:10.29 , date: '2022/01/07', credit: false}}
    let!(:venta) {{ sale: sale, ticket: products}}
    
    it 'adds a new Sell successfully' do
        
        post '/api/v1/sale/new', params: venta
        json = JSON.parse(response.body)
        expect(json['message']).to eql('Sale succesfully created.')
    end

   
end