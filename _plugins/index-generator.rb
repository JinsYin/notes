# jekyll-readme-index 不能对在 Front Matter Defaults 中指定了 permalink 的 'README' page 进行转换
module Jekyll
  class IndexGenerator < Jekyll::Generator
    attr_accessor :site

    def initialize(site)
      @site = site
    end

    def generate(site)
      @site = site

      site.pages.each do |page|
        # 暂不考虑同时出现 index 和 README 文件的情况
        if page.basename == "README" and page.permalink
          page.basename = "index"
        end
      end
    end

  end
end
