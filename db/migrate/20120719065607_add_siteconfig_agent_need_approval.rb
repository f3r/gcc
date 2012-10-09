class AddSiteconfigAgentNeedApproval < ActiveRecord::Migration
  def change
    add_column :site_configs, :agent_need_approval, :boolean, :default => true
  end
end
