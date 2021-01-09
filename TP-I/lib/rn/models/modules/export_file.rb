module Export
    def export_one_file(path)
        extension = "rn"

        # Me guardo el path original con la extension md ya que voy a convertir el arhcivo rn en md
        md_path = path + ".md"
        html_path = path + ".html"

        path += ".#{extension}"

        if File.exist?(path)
            #copio el archivo orignial y le cambio la extension a md para poder exportarlo
            FileUtils.cp path, "#{File.dirname(path)}/#{File.basename(path,'.*')}.md"
            
            md_file = File.read(md_path)
            html_file_content =  GitHub::Markdown.render(md_file)
            
            new_note = File.new(html_path, 'w')
            new_note.puts(html_file_content)
            new_note.close

            FileUtils.rm md_path

            return true 

            
        else
            return false 
        end
    end
    
    def export_multiple_files(path)
        Dir.entries(path).each do |filename|
            #VERIFICO SOLO LOS ARCHIVOS CON EXTENSION .RN
            if filename =~ /\.(?:rn)$/i
                #LE SACO LA EXTENSION AL FILENAME PARA PODER TRABAJAR EN EL MODULO
                filename_without_extension = File.basename(filename, File.extname(filename))
                #GENERO EL PATH CORRESPONDIENTE SIN LA EXTENSION RN
                path_without_extension = path + filename_without_extension
                #EXPORTO A TRAVES DEL MODULO EXTERNO NOTA X NOTA
                export_one_file(path_without_extension)
            end
        end
        return true
    end

end