require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe "Users" do
  before(:all) do
      @user = create(:user)
  end

  it "visit /user/:id" do
    visit edit_user_path(@user)
    expect(current_path).to eq(new_user_session_path)

    fill_in "Email", with: @user.email
    fill_in "Password",with: @user.password
    click_button "Log in"

    expect(current_path).to eq(edit_user_path(@user))
  end

  it "update /user/:id" do
    user = create(:user)

    login_as(user)
    visit edit_user_path(@user)

    new_firstname = @user.firstname + "1"
    new_lastname = @user.lastname + "1"
    fill_in "Firstname", with: @user.firstname
    fill_in "Lastname", with: @user.lastname

    expect{click_button "Update User"}.to change {@user.edited_histories.count}.to(1)
  end
end
