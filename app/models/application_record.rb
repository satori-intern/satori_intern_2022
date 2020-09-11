class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def name_maximum_len 
    return 255
  end
end
