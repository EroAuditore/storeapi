
require 'rails_helper'

describe 'Client API', type: :request do
    let!(:client_test) do
        FactoryBot.create(:client, name: 'Cliente de prueba', activo: true)
    end
    let(:client) {{ name: 'Cliente de prueba' }}
    
    it 'adds a new client successfully' do
        post '/api/v1/client/new', params: { client: client }
        json = JSON.parse(response.body)
        expect(json['message']).to eql('Client succesfully created.')
    end

    it 'client a produc successfully' do
      
        put '/api/v1/client/update', params: { id: client_test.id, name: 'Cliente de prueba nuevo', activo: true }
        json = JSON.parse(response.body)
        expect(json['message']).to eql('Client succesfully updated.')
        expect(json['data']['name']).to eql('Cliente de prueba nuevo')
        
    end

end