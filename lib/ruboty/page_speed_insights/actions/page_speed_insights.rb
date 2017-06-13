module Ruboty
  module PageSpeedInsights
    module Actions
      class PageSpeedInsights < Ruboty::Actions::Base
        def call
          message.reply('PageSpeedInsights')
        end
      end
    end
  end
end
