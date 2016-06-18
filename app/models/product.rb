class Product < ApplicationRecord
  after_create_commit {
    Keen.publish 'product' , self
    UpdateAnalyticsJob.perform_later self
  }

end
