FactoryBot.define do
  factory :ticket do
    name { nil }
    guid { SecureRandom.uuid }
    event { create(:event) }

    trait :claimed do
      name { "John Smith" }
      status { "claimed" }
      stripe_checkout_session_id { "some-random-stripe-id" }
    end

    trait :sold do
      name { "John Smith" }
      status { "sold" }
      stripe_checkout_session_id { "some-random-stripe-id" }
    end
  end
end
