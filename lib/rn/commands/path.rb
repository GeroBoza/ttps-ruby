module Path

    def check_my_rns()
        dir = "#{Dir.home}/.my_rns/"
        global_book = "#{Dir.home}/.my_rns/global_book"
  
        unless File.directory?(dir)
            FileUtils.mkdir_p(dir)
            FileUtils.mkdir_p(global_book)
        end
    end

    def valid_name?(a_name)
        if a_name.match("/")
            return false
        else 
            return true
        end
    end

end