class Admin::PageSettings
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  # add here other parameters (it allows to use it in the form in admin panel)
  attr_accessor :time_limit, :end_date

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end



