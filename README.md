# RecordRevision

## Install
### migrate
  ```
    rake record_revision:install:migrations
    rake db:migrate
  ```

### include the controller module
  ```ruby
    class ApplicationController < ActionController::Base
      include RecordRevision::Controller
    end
  ```
### include the model module
  ```ruby
    class Entry < ActiveRecord::Base
      include RecordRevision::Model
    end
  ```
### how to chenge current_user?
  add class method to controller
  ```ruby
    def self.set_record_revision_user
      Thread.current["record_revision_current_user"] = self.current_user
    end
  ```
