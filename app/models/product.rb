class Product < ApplicationRecord
  after_create_commit {
    Keen.publish 'product' , self
    UpdateAnalyticsJob.perform_later self
  }


  after_destroy {
    Keen.delete 'product' , self
    UpdateAnalyticsJob.perform_later self
  }
end
