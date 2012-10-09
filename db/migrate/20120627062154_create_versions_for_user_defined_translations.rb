class CreateVersionsForUserDefinedTranslations < ActiveRecord::Migration
  def up
    Translation.where('created_at <> updated_at').all.each do |tr|
      tr.versions.create(:value => tr.value) unless tr.versions.any?
    end
  end

  def down
  end
end
