module AuthorHelper
  extend ActiveSupport::Concern

  def self.show_all_authors
    authors = Author.all
    authors.each do |a|
      puts a.name
    end
  end
end
