class AddSiteConfigStaticAssets < ActiveRecord::Migration
  def change
    add_column :site_configs, :static_assets_path, :string
    path = "http://s3.amazonaws.com/#{Paperclip::Attachment.default_options[:bucket]}/static"
    execute %{
      UPDATE site_configs SET static_assets_path = '#{path}'
    }
  end
end
