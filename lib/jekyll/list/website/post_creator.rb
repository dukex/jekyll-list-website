module Jekyll
  module List
    module Website
      class PostCreator
        def self.write(post)
          filename = File.join("_posts", post.filename)
          return if File.exists?(filename)

          File.open(filename, "w") do |f|
            write_frontmatter(f, post)
          end
        end

        def self.write_frontmatter(f, post)
          f.puts YAML.dump(post.data.merge({
            "permalink" => post.permalink,
            "categories" => post.categories,
            "category" => post.main_category,
            "tags" => post.tags,
            "link" => post.url
          }))

          f.puts "---"
        end
      end
    end
  end
end
