require 'active_support'
require 'active_support/all'
require 'unidecoder'

I18n.config.available_locales = :en
I18n.locale = :en

module Jekyll
  module List
    module Website
      class Post
        include ActiveSupport::Inflector

        attr_reader :markup, :data

        MissingDataError = Class.new(RuntimeError)

        def initialize(data)
          @markup = 'markdown'
          @data = data
        end

        def published_at
          Time.parse data['publish_date']
        end

        def title
          data['title']
        end

        def categories
          (data['categories'] || []).map { |c| c['category'] }
        end

        def tags
          (data['tags'] || []).map { |t| t['tag_name'] }
        end

        def url
          data['url']
        end

        def main_category
          categories.first
        end

        def permalink
          "#{slugify(main_category)}/#{slugify(title)}/"
        end

        def filename
          "#{published_at.strftime("%Y-%m-%d")}-#{File.basename(slugify(title), ".*")}.#{markup}"
        end

        def slugify(text)
          transliterate(text.to_ascii.downcase.strip.gsub(' ', '-')).gsub(/[^\w-]/, '').gsub(/-{2,}/, '-')
        end
      end
    end
  end
end
