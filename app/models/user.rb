class User < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  has_secure_password

  after_destroy :ensure_an_admin_remains

  private

    def ensure_an_admin_remains
      if User.count.zero?
        raise StandardError.new "Can't delete the last admin."
      end
    end
end
