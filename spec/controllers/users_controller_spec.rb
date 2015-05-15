require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before(:all) do
      @user = create(:user)
  end

  it 'create successfully new user with valid information' do
    user = create(:user)
    expect(user.firstname).to eq(User.last.firstname)
  end

  context 'create new user with valid information' do
    RSpec.shared_examples "new info can not be blank" do |field|
      it "#{field} should not be blank" do
        user = build(:user)
        user[field] = ''
        user.save
        expect(user.new_record?).to be true
      end
    end

    include_examples "new info can not be blank", :firstname
    include_examples "new info can not be blank", :lastname
    include_examples "new info can not be blank", :dob
  end

  context 'update user with valid information' do
    RSpec.shared_examples "update info can not be blank" do |field|
      it "#{field} should not be blank" do
        user = create(:user)
        user[field] = ''
        expect(user.valid?).to be false
      end
    end

    include_examples "update info can not be blank", :firstname
    include_examples "update info can not be blank", :lastname
    include_examples "update info can not be blank", :dob
  end
end
