class AuthorLoggerWorker
  include Sidekiq::Worker
  sidekiq_options queue: :default

  #retry: false/5
  #retry-queue: 'name that queue'
  #dead: false -> retry and disappear, dont go to dead set
  #
  def perform(message)
    Rails.logger.info("Author Logger Job: #{message}")
  end
end
