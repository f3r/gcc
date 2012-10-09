module ControllerMacros
  # def login_admin
  #   before(:each) do
  #     @request.env["devise.mapping"] = Devise.mappings[:admin]
  #     sign_in Factory.create(:admin) # Using factory girl as an example
  #   end
  # end

  def login_as(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end
end