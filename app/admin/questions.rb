ActiveAdmin.register Comment, :as => "Question" do
  menu :priority => 2, :parent => 'E-Commerce'
  #We don't need new question button
  actions :all, :except => :new

  scope :questions, :default => true

  filter :comment

  index do
    id_column
    column :product, :sortable => :product_id
    column :user, :sortable => :user_id
    column 'Question', :comment
    column('Answer') {|q| q.reply.comment if q.reply }
    column :created_at
    column(:responded_at) {|q| l(q.reply.created_at, :format => :long) if q.reply }
    default_actions
  end

  show do |question|
    attributes_table do
      row :id
      row :product
      row("QUESTION") {question.comment}
      row :user
      row( question.replying_to.present? ? 'REPLYING TO' : 'ANSWER') do
          if question.replying_to.present?
            reply_to_question = Comment.find(question.replying_to)
            link_to 'View', admin_question_path(reply_to_question)
          elsif question.answers.count > 0
            link_to 'View', admin_question_path(question.answers[0])
          end
        end

      row :created_at
    end
  end

  form do |f|
    f.inputs do
      f.input :id, :input_html => { :disabled => true }
      f.input :product, :input_html => { :disabled => true }
      f.input :comment, :label => "Question"
      f.input :user, :input_html => { :disabled => true }
      f.input :created_at, :input_html => { :disabled => true }
    end
    f.buttons
  end

end
