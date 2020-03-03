module Jekyll
  class Page

    # 新增函数
    # subpath 等于 path 除去 source 以外的路径
    def subpath
      path = @dir
      if !data.nil? and data["source"]
        subpath = path.split(data["source"])[1]
      end
      subpath
    end

    # 覆写原函数
    def url_placeholders
      {
        :path       => @dir,
        :subpath    => subpath, # New field #
        :basename   => basename,
        :output_ext => output_ext,
      }
    end

  end
end
