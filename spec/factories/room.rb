FactoryBot.define do
  factory :room do
    name { Faker::Name.name }
    bed_type { '1 king' }
    breakfast { true }
    ac { true }
  end
end
