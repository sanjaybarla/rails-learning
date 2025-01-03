class AuthorLoggerJob
  include Sidekiq::Job
  sidekiq_options queue_as :default

  #retry: false/5
  #retry-queue: 'name that queue'
  #dead: false -> retry and disappear, dont go to dead set
  #
  def perform(message)
    Rails.logger.info("Author Logger Job: #{message}")
  end
end
