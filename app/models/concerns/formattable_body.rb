# frozen_string_literal: true

module FormattableBody
  extend ActiveSupport::Concern

  FORMATTERS = [
    -> (text) {
      # **[строка]** => <b>[строка]</b> (выделение жирным)
      text.gsub(/\*\*(.+?)\*\*/) { "<b>#{$1}</b>" }
    },
    -> (text) {
      # \\[строка]\\ => <i>[строка]</i> (выделение курсивом)
      text.gsub(/\\\\(.+?)\\\\/) { "<i>#{$1}</i>" }
    },
    -> (text) {
      # ((name1/name2/name3 [строка]))
      # преобразовывать в ссылку на страницу
      # <a href="[site]name1/name2/name3">[строка]</a>
      root_path = Rails.application.routes.url_helpers.root_path
      text.gsub(
        /\(\(([a-zA-Zа-яА-ЯёЁ0-9_\/]+)\s(.+?)\)\)/
      ) { "<a href=\"#{root_path}#{$1}\">#{$2}</a>" }
    },
  ]

  included do
    before_save :set_formatted_body, if: :body_changed?

    private

    def set_formatted_body
      self.formatted_body = '' and return if body.blank?
      self.formatted_body = FORMATTERS.inject(body) do |text, formatter|
        formatter.call(text)
      end
    end
  end
end
