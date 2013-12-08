require "record_revision/engine"

module RecordRevision

  # please include me!!
  module Controller
    def self.included(base)
      base.before_action :set_record_revision_user
      base.after_action :clear_record_revision_user
      base.extend(ClassMethods)
    end 

    module ClassMethods
      def set_record_revision_user(attr=:current_user)
        @@record_revision_user_attr ||= attr
      end
    end

    def set_record_revision_user
      Thread.current["record_revision_current_user"] = self.current_user
    end

    def clear_record_revision_user
      Thread.current["record_revision_current_user"] = nil
    end
  end

  # please include me!!
  module Model
    def self.included(base)
      base.after_create :insert_create_revision
      base.after_destroy :insert_destroy_revision
      base.after_update :insert_update_revision
    end 

    # insert revision at call by insert_XXXX_revisoin methods.
    def insert_revision(operation)
      current_user = Thread.current["record_revision_current_user"]
      if current_user
        RecordRevision::Data.create do |r| 
          r.parent    = self
          r.operation = operation
          r.data      = self.to_json unless operation == :destroy
          r.author    = current_user
        end
      end
    end

    # get revisions of mine.
    def revisions
      RecordRevision::Data.by_parent(self).order(:id)
    end

    # author by last revision.
    def last_updated_user
      revisions.last.try(:author)
    end

    # author by first revision.
    def created_user
      revisions.first.try(:author)
    end

    # insert revision with call create-callback.
    def insert_create_revision
      insert_revision(:create)
    end

    # insert revision with call destroy-callback.
    def insert_destroy_revision
      insert_revision(:destroy)
    end

    # insert revision with call update-callback.
    def insert_update_revision
      insert_revision(:update)
    end
  end
end
