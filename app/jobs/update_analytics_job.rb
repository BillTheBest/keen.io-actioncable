class UpdateAnalyticsJob < ApplicationJob
  queue_as :default

  def perform(product)
    ActionCable.server.broadcast 'analytics_channel', product: product
  end
end
