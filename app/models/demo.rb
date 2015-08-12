class Demo
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :details, type: String

  validates_presence_of :name, :details

end
