FactoryBot.define do
    factory :credit do
        paid { false}
        total {100}
        client
        
        trait :paid do
            paid {true}
        end

         factory :paid_credit, traits: [:paid]
    end
end