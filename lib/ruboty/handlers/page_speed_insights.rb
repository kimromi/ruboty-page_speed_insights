require "ruboty/page_speed_insights/actions/page_speed_insights"

module Ruboty
  module Handlers
    class PageSpeedInsights < Base
      on(
        /psi (?<url>.*?)\z/,
        name: 'page_speed_insights',
        description: 'output PageSpeed Insights result'
      )

      def page_speed_insights(message)
        Ruboty::PageSpeedInsights::Actions::PageSpeedInsights.new(message).call
      end
    end
  end
end
