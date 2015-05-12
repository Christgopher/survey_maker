class Survey <ActiveRecord::Base
  has_many(:questions)

  before_save(:capitalize_letter)

  private

  define_method(:capitalize_letter) do
    self.title=(title().capitalize())
  end
end
