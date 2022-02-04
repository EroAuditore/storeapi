FactoryBot.define do
    factory :ticket do
      description { "Ticket description" }
      sale
    end
  
    # factory :sale do
    #   total { 100 }
  
    #   factory :sale_with_ticketss do
    #     transient do
    #       tickets_count { 5 }
    #     end
  
    #     tickets do
    #       Array.new(tickets_count) { association(:ticket) }
    #     end
    #   end
    # end
  end