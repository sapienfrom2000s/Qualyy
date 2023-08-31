
module LoginHelper
  def log_in_as(email)
    visit '/users/sign_in'
    fill_in 'Password', with: 'password'
    fill_in 'Email', with: email
    
    click_button 'Log in'
  end
end