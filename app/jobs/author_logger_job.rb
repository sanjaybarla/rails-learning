class AuthorLoggerJob
  include Sidekiq::Job
  queue_as :default

  def perform(message)
    Rails.logger.info("Author Logger Job: #{message}")
  end
end
