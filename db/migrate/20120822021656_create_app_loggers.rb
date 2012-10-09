class CreateAppLoggers < ActiveRecord::Migration
  def change
    create_table :app_loggers do |t|
      t.string  :url
      t.string  :controller
      t.string  :action
      t.string  :method
      t.text    :params
      t.string  :user_id
      t.string  :user_role
      t.string  :user_email
      t.timestamps
    end
  end
end
