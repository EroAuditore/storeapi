class Sale < ApplicationRecord
    has_many :tickets
    def self.sales_today
        @sales = self.where(date: Date.today.at_beginning_of_day..Date.today.at_end_of_day).sum(:total)
        @sales.group_by {|sale| sale.date.to_date }
    end

    def self.sales_week
        @sales = self.select("date, total").where(date: Date.today.beginning_of_week.at_beginning_of_day..Date.today.at_end_of_day).group("date(date)").sum(:total)
        
    end
    
    def self.sales_month
        self.select("date, total").where(date: Date.today.beginning_of_month.at_beginning_of_day..Date.today.at_end_of_day).group("date(date)").sum(:total)
        
    end
end
