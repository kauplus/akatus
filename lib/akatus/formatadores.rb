module Akatus

  def self.formatar_numero(number)
    ActiveSupport::NumberHelper.number_to_rounded(number.try(:to_d), :precision => 2, :separator => '', :delimiter => '')
  end

end