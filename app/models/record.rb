class Record < ActiveRecord::Base
attr_accessible :title, :content
belongs_to :user

validates :title,   :length => { :maximum => 100 }

validates :content, :presence => true,
                    :length => { :maximum => 10.kilobytes }
end
