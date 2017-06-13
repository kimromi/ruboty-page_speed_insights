module Ruboty
  module PageSpeedInsights
    module Actions
      class PageSpeedInsights < Ruboty::Actions::Base
        def call
          url = message.match_data[:url].strip

          attachments = %i(
            desktop
            mobile
          ).each_with_object([]) do |strategy, array|
            google_url = "https://www.googleapis.com/pagespeedonline/v2/runPagespeed?url=#{url}&strategy=#{strategy}&key=#{ENV['GOOGLE_TOKEN']}"
            data = JSON.parse(open(google_url, &:read))

            fields = [{title: 'Score', value: data['ruleGroups']['SPEED']['score'], short: true }]
            fields.concat(data['pageStats'].map {|key, value| {title: key, value: value, short: true }})

            array << {
              color: strategy == :desktop ? '#64b639' : '#1bbee7',
              author_name: strategy.to_s.upcase,
              author_link: "https://developers.google.com/speed/pagespeed/insights/?hl=en&url=#{url}&tab=#{strategy}",
              fields: fields,
              ts: Time.now.to_i
            }
          end

          message.reply('PageSpeed Insights Result', attachments: attachments) # for slack_rtm
        end
      end
    end
  end
end
