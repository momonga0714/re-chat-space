FactoryBot.define do
  
  factory :message do
    content        {Faker::Lorem.sentence}
    image          {File.open("#{Rails.root}/spec/fixtures/mv2_sp.jpg")}
    created_at     { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    group
    user
  end

end