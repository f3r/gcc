require 'spec_helper'

describe ProductsHelper do
  before(:each) do
    @product = create(:product)
  end

  context "Custom fields" do
    it "renders input for a text field" do
      cf = create(:custom_field, name: 'favorite_food', label: 'Favorite Food', type: :string)
      html = custom_field_input(cf, @product)
      html.should have_selector("input[name='listing[custom_fields][favorite_food]']")
      html.should have_selector("input[type='text']")
    end

    it "renders input for a dropdown field" do
      cf = create(:custom_field, name: 'dropdown_field', label: 'Select Option', type: :dropdown, values: 'First Option, Second Option')
      html = custom_field_input(cf, @product)
      html.should have_selector("select[name='listing[custom_fields][dropdown_field]']")
      html.should have_selector("option", :text => 'First Option')
      html.should have_selector("option", :text => 'Second Option')
    end

    it "renders input for a checkbox_group field" do
      cf = create(:custom_field, name: 'languages', label: 'Languages', type: :checkbox_group, values: 'English, French, Spanish')
      @product.custom_fields = {'languages' => ['French', 'Spanish']}

      html = custom_field_input(cf, @product)
      expected_name = 'listing[custom_fields][languages][]'
      html.should have_selector("input[name='#{expected_name}']", :count => 3)
      html.should have_selector("input[name='#{expected_name}'][value='English']")
      html.should_not have_selector("input[name='#{expected_name}'][checked=checked]", :with => 'English')
      html.should have_selector("input[name='#{expected_name}'][checked=checked]", :with => 'French')
      html.should have_selector("input[name='#{expected_name}'][checked=checked]", :with => 'Spanish')
    end

    it "renders the value for a checkbox_group field" do
      cf = create(:custom_field, name: 'languages', label: 'Languages', type: :checkbox_group, values: 'English, French, Spanish')
      @product.custom_fields = {'languages' => ['French', 'Spanish']}
      html = custom_field_value(cf, @product)
      html.should == 'French, Spanish'
    end
  end
end