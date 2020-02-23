FactoryBot.define do
  factory :ticket do
    name { nil }
    guid { SecureRandom.uuid }
    event { create(:event) }
  end
end
