class User
  module Roles
    extend ActiveSupport::Concern

    included do
      attr_accessor :manager_admin
      belongs_to :controls_user, :class_name => 'User'
    end

    def is_taken?
      !self.manager_admin.nil?
    end

    def super_admin?
      self.role == 'superadmin'
    end

    def admin?
      self.role == 'admin' || self.role == 'superadmin'
    end

    def agent?
      self.role == 'agent'
    end

    def consumer?
      self.role == 'user'
    end

    def role_symbols
      [role.to_sym]
    end

    def take_control(target_user)
      self.controls_user = target_user
      self.save
    end

    def release_control
      self.controls_user = nil
      self.save
    end

    # The user that is currently being controlled
    def controlled_user
      if admin? && self.controls_user_id
        user = self.controls_user
        user.manager_admin = self
        user
      else
        self
      end
    end

  end
end