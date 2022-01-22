
require 'rails_helper'

describe 'Products API', type: :request do
    let!(:product_test) do
        FactoryBot.create(:product, description: 'product test', code: '1234556789', sale_price:10_99, purchase_price: 10_99, bulk_price: 1, bulk: false)
      end
      let(:product) {{ description: 'product test', code: '1234556789', sale_price:10_99, purchase_price: 10_99, bulk_price: 1, bulk: false }}
    
    it 'adds a new produc successfully' do
        post '/api/v1/product/new', params: { product: product }
        json = JSON.parse(response.body)
        expect(json['message']).to eql('product succesfully created.')
    end

    it 'update a produc successfully' do
      
        put '/api/v1/product/update', params: { id: product_test.id, description: 'new description', code: '1234556789', sale_price:10_99, purchase_price: 10_99, bulk_price: 1, bulk: false }
        json = JSON.parse(response.body)
        expect(json['message']).to eql('product succesfully updated.')
        expect(json['data']['description']).to eql('new description')
        
    end

end