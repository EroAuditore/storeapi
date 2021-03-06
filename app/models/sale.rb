class Sale < ApplicationRecord
    has_many :tickets
    
    belongs_to :credits, optional: true
    def self.sales_today
        @sales = self.select("date, total").where(date: Time.zone.today.at_beginning_of_day.utc..Time.zone.today.at_end_of_day.utc).group("date(date)").sum(:total)
        sales_json = []
      
         @sales.each { |sale| sales_json << { date: sale[0], total: sale[1] }  
        }
      
        return sales_json
        
    end

    def self.sales_week
        @sales = self.select("date, total").where(date: Time.zone.today.beginning_of_week.at_beginning_of_day.utc..Time.zone.today.at_end_of_day.utc).group("date(date)").order("date(date)").sum(:total)
        sales_json = []
      
         @sales.each { |sale| 
            sales_json << { :date => sale[0], :total => sale[1]} 
        }

        
        return sales_json
        
    end
    
    def self.sales_month
        @sales = self.select("date, total").where(date: Time.zone.today.beginning_of_month.at_beginning_of_day.utc..Time.zone.today.at_end_of_day.utc).group("date(date)").sum(:total)
        sales_json = []
      
         @sales.each { |sale| 
            sales_json << { date: sale[0], total: sale[1] }  
            }
      

        return sales_json
    end
end
