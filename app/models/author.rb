class Author < ApplicationRecord
  # include AuthorHelper

  # enum :gender, {
  #   female: 0,
  #   male: 1,
  #   other: 2
  # }, prefix: true
  #, prefix: true -> gender is prefix

  enum :gender, %i(female, male, other), prefix: true

  # default_scope {where gender: :female} #it was applied default to the queries
  scope :female_author, -> {where(gender: :female)}

  scope :male_authors, ->{ where(gender: :male) }

  scope :order_by_name, ->{ order(name: :desc) }

  scope :min_age, ->(age) { where('dob <= ?', Date.today - age.years) }

  scope :name_contains, ->(name) { where('name LIKE ?',"%#{name}%") }

  scope :limit_to, ->(number) { limit(number)}


  #scope with eager_loading

  scope :with_books, -> {includes(:books).includes(:journals)}

  # scope :with_books_and_journals, -> { includes(:books, :journals).where.not(books: {id: nil}).where.not(journals: {id: nil}) }

  scope :with_books_and_journals, -> { includes(:books, :journals) }
  #we need to add _ to get the data.. for this
  # enum :gender, %i(female, male, other), suffix: true
  # enum :gender,

  has_many :books

  has_many :journals, dependent: :destroy

  #belongs-to: nil -> has_one
  has_one :latest_book, -> { order(created_at: :desc) }, class_name: 'Book'

  has_one :latest_journal, -> { order(created_at: :desc) }, class_name: 'Journal'

  has_many :books_starts_with, -> { where('title LIKE ?','F%').order(title: :asc) }, class_name: 'Book'

  #has_one: shows only one record -> has_many
  has_many :last_3_books, -> { order(created_at: :desc).limit(3) }, class_name: 'Book'

  before_validation :welcome_message

  validates :dob, presence: true
  validate :validate_age
  validates :gender, presence: true

  after_update :log_changes
  after_create :log_creation
  before_update { puts "welcome" }

  before_create do
    self.name = self.name.capitalize
  end

  #need to add callback
  after_update :log_changes

  #proc and lambda

  AGEPROC = Proc.new do |age|
    where('dob >= ?', Date.today - age.years)
  end

  def self.older_authors(age)
    AGEPROC.call(age)
  end


  #sample proc

  def self.proc_sample
    proc_demo = Proc.new {return "Hi i am in braces"}
    proc_demo.call
    "i am not printing..."
  end

  #sample lambda

  def self.lambda_sample
    l_demo = lambda {return "I am in braces"}
    l_demo.call
    "I am printing...."
  end



  #lambda

  FILTER_LAMBDA = lambda {|g_val| where(gender: g_val)}

  def self.authors_by_gender(g)
    FILTER_LAMBDA.call(g)
  end


  #eager loading

  def self.fetch_eager_loading
    Author.with_books_and_journals.each do |a|
      puts "Author: #{a.name}"
      puts "Books: #{a.books.count}"
      puts "Journals: #{a.journals.count}"
    end
  end


  def self.fetch_lazy_loading
    Author.all.each do |a|
      puts "Author: #{a.name}"
      puts "Books: #{a.books.count}"
      puts "Journals: #{a.journals.count}"
    end
  end





  def self.show_all_authors
    authors = Author.all
    authors.each do |a|
      puts a.name
    end
  end

  def self.calculate_ages
    ages = []
    Author.all.each do |a|
      per = (Date.today - a.dob).to_i/365
      ages << per
    end
    ages
  end
  #
  # Gender = {0=>'female',1=>'male',2=>'other'}
  #
  # def show_genderr
  #   Gender[gender] || "Unknownn"
  # end
  #
  #
  # def show_gender
  #   if gender==0
  #     return "female"
  #   end
  #
  #   if gender==1
  #     return "male"
  #   end
  #
  #   if gender==2
  #     return "other"
  #   end
  # end

  def age
    (Date.today - dob).to_i/365
  end

  private


  def welcome_message
    # Rails.logger.info "welcome"
    # AuthorLoggerJob.perform_later("Author #{name} has been validated.")
  end



  def validate_age
    if dob.present? && age < 18
      errors.add(:dob, "must correspond to an age of at least 18 years. Your age is #{age}.")
      # Rails.logger.info "Must corresponding to an age of at least 18 years."
      # AuthorLoggerJob.perform_later("Age validation failed for Author #{id}. Age is #{age}.")
    end
  end



  def log_changes
    if dob_changed?
      # Rails.logger.info "Author #{id} changed date of birth"
      # AuthorLoggerJob.perform_later("Author #{id} changed date of birth.")
      AuthorLoggerJob.perform_later("Author #{id} changed date of birth to #{dob}")
    end

    if gender_changed?
      # Rails.logger.info "Author #{id} changed gender"
      AuthorLoggerJob.perform_later("Author #{id} changed gender to #{gender}")
    end
  end

  def log_creation
    AuthorLoggerJob.perform_later("Author #{name} was created with the ID: #{id}")
  end
  # def show_message
  #   puts "Your record was created"
  # end

  # def latest_book
  #   books.order(created_at: :desc).first
  # end

  # def last_3_books
  #   books.order(created_at: :desc).limit(3)
  # end

  # def ll
  #   book = books.last
  # end
  #
  # def books_list
  #   books
  # end

  # def books_and_journals
  #   (books+journals)
  # end

end



