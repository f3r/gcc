require 'spec_helper'

describe HomeController do
  it "responds telling that it is alive" do
    get :alive
    response.should be_success
  end
end
