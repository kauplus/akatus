# External libraries
require 'active_support/inflector'
require 'active_support/number_helper'
require 'bigdecimal'
require 'i18n'
require 'json'
require 'rest-client'

# Configuration and modules
require 'akatus/configuration'
require 'akatus/errors'
require 'akatus/formatters'
require 'akatus/transferrable'
require 'akatus/version'

# Business classes
require 'akatus/address'
require 'akatus/installment'
require 'akatus/installment_options'
require 'akatus/item'
require 'akatus/payer'
require 'akatus/payment'
require 'akatus/payment_option'
require 'akatus/payment_types'
require 'akatus/phone'
require 'akatus/receiver'
require 'akatus/service'
require 'akatus/services/installments'
require 'akatus/services/payment_options'
require 'akatus/services/transaction'
require 'akatus/split_fee'

require_relative '../config/i18n'

module Akatus
end
