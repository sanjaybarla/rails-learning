class AuthorLoggerJob < ApplicationJob
  queue_as :default

  # The perform method will handle the job logic
  def perform(message)
    # Logic to save the message to a log, could be saving to a file, DB, or a service
    Rails.logger.info("Author Logger Job: #{message}")
    # You can also integrate with external logging systems, like Loggly, Splunk, etc.
  end
end
