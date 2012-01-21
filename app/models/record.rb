class Record < ActiveRecord::Base
  attr_accessible :title, :content, :tag_names
  attr_writer :tag_names

  belongs_to :user
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings

  validates :title,   :length => { :maximum => 100 }

  validates :content, :presence => true,
                      :length => { :maximum => 10.kilobytes }

  before_save :count_words
  after_save :assign_tags
  default_scope :order => 'records.created_at DESC'
  scope :published #stub TODO : implement publish function

  def tag_names
    @tag_names ||= tags.map{ |tag| tag.name }.join( ', ')
  end

  private
    def count_words
      self.word_count = content.split.size
    end

    def assign_tags
      if @tag_names
        self.tags = @tag_names.split( /\s*[,;]\s*/ ).map do |name|
          Tag.find_or_create_by_name( name )
        end
      end
    end
end
