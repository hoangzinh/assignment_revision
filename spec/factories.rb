Factory.define :user do |f|
  f.sequence(:email) { |n| "foo#{n}@example.com" }
  f.password "foobarzz"
  f.fistname "foo"
  f.lastname "bar"
  f.dob DateTime.new
end