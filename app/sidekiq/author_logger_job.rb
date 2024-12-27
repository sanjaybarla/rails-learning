class AuthorLoggerJob < ApplicationJob
  queue_as :default

  def perform(message)
    # Log the message asynchronously to the Sidekiq logs
    logger = Logger.new(Rails.root.join('log', 'sidekiq_author_logs.log'))
    logger.info(message)
  end
end
