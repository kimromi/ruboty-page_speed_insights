module Ruboty
  module PageSpeedInsights
    module Actions
      class PageSpeedInsights < Ruboty::Actions::Base
        def call
          url = message.match_data[:url].strip
          unless url =~ %r(https?://[\w/:%#\$&\?\(\)~\.=\+\-]+)
            message.reply("Invalid URL #{url}")
            return
          end

          message.reply('Fetching PageSpeed Insights Result...')

          results = %i(
            desktop
            mobile
          ).each_with_object({}) do |strategy, hash|
            google_url = "https://www.googleapis.com/pagespeedonline/v2/runPagespeed?url=#{url}&strategy=#{strategy}&key=#{ENV['GOOGLE_TOKEN']}"
            data = JSON.parse(open(google_url, &:read))

            hash[strategy] = { score: data['ruleGroups']['SPEED']['score'] }.merge(data['pageStats'])
          end

          # for slack_rtm
          attachments = results.map do |strategy, scores|
            {
              color: strategy == :desktop ? '#64b639' : '#1bbee7',
              author_name: strategy.to_s.upcase,
              author_link: "https://developers.google.com/speed/pagespeed/insights/?hl=en&url=#{url}&tab=#{strategy}",
              fields: scores.map {|stats, score| { title: stats, value: score, short: true } },
              ts: Time.now.to_i
            }
          end

          message.reply("PageSpeed Insights Result #{results.map{|k, v| "#{k.capitalize}: #{v[:score]}"}.join(', ')}", attachments: attachments)
        end
      end
    end
  end
end
