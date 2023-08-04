FactoryGirl.define do
  factory :user_event do
    user nil
    user_device nil
    event_type_const "MyString"
    description "MyText"
  end
end
