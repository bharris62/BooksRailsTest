require 'net/http'
class UpdateSkuJob < ApplicationJob
  queue_as :default

  def perform(book_name)
    # logic
  end
end
