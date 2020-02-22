FactoryBot.define do
  factory :event do
    available_tickets_count { 5 }
    claimed_tickets_count { 0 }
    sold_tickets_count { 0 }
  end
end
