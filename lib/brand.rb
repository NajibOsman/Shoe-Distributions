class Brand <ActiveRecord::Base
  belongs_to_many(:stores)
end
