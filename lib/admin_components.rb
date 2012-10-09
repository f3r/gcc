class TEdit < Arbre::Component
  builder_method :tedit

  def build(label_text, key, attributes = {})
    t = Translation.find_by_key(key)
    label label_text
    div :class => 'translation' do
      span :class => 'value' do
        t(key)
      end
      span :class => 'actions' do
        if t
          link_to('Edit', edit_admin_translation_path(t))
        else
          link_to('Edit', new_admin_translation_path(:key => key))
        end
      end
    end
  end
end