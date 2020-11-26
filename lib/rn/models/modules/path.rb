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

    def create_path(book, title)
        if book != nil
            path = "#{Dir.home}/.my_rns/#{book}/#{title}"   
        else
            path = "#{Dir.home}/.my_rns/global_book/#{title}"
        end
    end

end