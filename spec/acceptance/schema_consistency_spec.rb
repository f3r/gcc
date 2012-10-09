require 'acceptance/acceptance_helper'

feature 'schema.rb consistency' do

  scenario 'check missing migrations files' do
    %x[rake db:migrate:status | grep "NO FILE" | wc -l].to_i.should be_equal(0),
      "8-) You are commiting an invalid schema.rb please rollback your non commited migrations"
  end
  # TO FIX THIS:
  #   run `rake db:migrate:status` and revert all the NO FILE migrations (`rake db:migrate:down VERSION=?`)

  scenario 'check down migrations' do
    %x[rake db:migrate:status | grep '^[ ]*down' | wc -l].to_i.should be_equal(0),
      "8-) Please run rake db:migrate before pushing"
  end
  # TO FIX THIS:
  #   run `rake db:migrate`
end
