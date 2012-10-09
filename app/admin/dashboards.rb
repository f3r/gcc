require_dependency 'ar_stats'
require_dependency 'google_funnel_chart'
require_dependency 'google_visualization'

klass = SiteConfig.product_class

ActiveAdmin.register_page "Dashboard" do
  menu :label => "Dashboard", :priority => 0

  content do
    table do
      tr do
        td do
          panel "Users" do
            stats = User.histo_counts(:cummulative => false)

            render('/admin/chart', :title => 'Users', :stats => stats)
          end
        end

        td do
          panel klass.name.pluralize do
            stats = klass.histo_counts(:cummulative => false)

            render('/admin/chart', :title => klass.name.pluralize, :stats => stats)
          end
        end
      end

      tr do
        td do
          panel "Agents Pipeline" do
            google_funnel_chart(AdminDashboard.agent_funnel, {:height => 140, :bar_color => "0099BB", :width => 550, :height => 200})
          end
        end

        td do
          panel "Transaction - Funnel" do
            google_funnel_chart(AdminDashboard.transaction_funnel, {:bar_color => "007799", :width => 550, :height => 200})
          end
        end
      end

      tr do
        td do
          panel "Users Pipeline" do
            google_funnel_chart(AdminDashboard.user_funnel, {:height => 140, :width => 550, :bar_color => "005577"})
          end
        end
      end
    end
  end
end
