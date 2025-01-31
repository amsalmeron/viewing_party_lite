require 'rails_helper'

RSpec.describe 'New User Registation Page', type: :feature do

  it "has a form to create a new user and taken back to user show page" do
    user = User.create!(name: 'Chealsea', email: 'chealsea@comcast.net', password: 'password')
    visit register_path
    fill_in :name, with: 'George'
    fill_in :email, with: 'banana@gmail.com'
    fill_in :password, with: 'password'
    fill_in :password_confirmation, with: 'password'
    click_button 'Register User'
    expect(current_path).to eq(user_path(User.last.id))
    expect(page).to have_content('Name: George') 
    expect(page).to have_content('E-mail: banana@gmail.com')
    expect(page).to_not have_content('Name: Chealsea')
  end

  it "takes user back to form if information for new user is not filled out correctly" do
    visit register_path
    fill_in :name, with: 'George'
    fill_in :email, with: 'banana@gmail.com'
    fill_in :password, with: 'password'
    fill_in :password_confirmation, with: 'password123'
    click_button 'Register User'
    expect(current_path).to_not eq(user_path(User.last.id))
    expect(current_path).to eq("/register")
    expect(page).to have_content("User not created: Please fill out credentials fully and correctly")
    expect(page).to_not have_content('Name: George') 
    expect(page).to_not have_content('E-mail: banana@gmail.com')
  end
  
end
