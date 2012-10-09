ActiveAdmin.register_page "Transaction Flow" do
  require_dependency 'admin_components'

  menu :parent => 'CMS'

  content do
    panel "Entities" do
      div do
        translatable_entities.each do |label, k|
          tedit label, k
        end
        div :class => 't_example' do
          h3 "Example"
          div t('pages.front_page.description.full')
        end
      end
    end

    # panel "Verbs" do
    #   translatable_verbs.each do |k|
    #     tedit k, k
    #   end
    # end

    panel "Transactions" do
      translatable_workflow.each do |k|
        tedit k, k
      end
    end
  end
end