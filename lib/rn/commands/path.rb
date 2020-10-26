module Path

    def check_my_rns()
        dir = "#{Dir.home}/.my_rns/"
  
        unless File.directory?(dir)
            FileUtils.mkdir_p(dir)
        end
    end

end