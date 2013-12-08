module RecordRevision
  class Data < ActiveRecord::Base
    belongs_to :parent, polymorphic: true
    belongs_to :author, polymorphic: true

    scope :by_parent, ->(parent) {where(parent: parent)}
    scope :by_author, ->(user) {where(author: user)}
  end
end
