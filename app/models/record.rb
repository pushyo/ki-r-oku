class Record < ActiveRecord::Base
  attr_accessible :title, :content

  belongs_to :user

  validates :title,   :length => { :maximum => 100 }

  validates :content, :presence => true,
                      :length => { :maximum => 10.kilobytes }

  before_save :count_words
  default_scope :order => 'records.created_at DESC'
  scope :published #stub TODO : implement publish function

  private
    def count_words
      self.word_count = content.split.size
    end
end
