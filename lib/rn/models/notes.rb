require_relative "path"
require 'fileutils'
require 'tty-editor'
class Note
    include Path

    def create(title, **options)
        book = options[:book]
        content = options[:content]

        if !valid_name?(title)
            warn "El titulo de la nota no puede contener el caracter '/'"
            return
        end

        # CHEQUEO QUE EL DIRECTORIO PRINCIPAL MY_RNS EXISTA, SI NO EXISTE SE CREA POR UNICA VEZ
        check_my_rns()

        # SI LLEGA COMO PARAMETRO UN BOOK SE SELECCIONA EL PATH CON EL BOOK CORRESPONDIENTE
        # SINO EL PATH INDICA EL DIRECTORIO GLOBAL MY_RNS
        path = create_path(book, title)

        extension = "rn"
        dir = File.dirname(path)

        # SI NO EXISTE EL BOOK INDICADO SE CANCELA LA CREACION DE LA NOTA Y SE INDICA EL ERROR
        unless File.directory?(dir)
            warn "El libro '#{book}' no existe, por favor creelo utilizando los comandos rn book create 'NOMBRE'"
            return
        end

        path << ".#{extension}"

        # VALIDO QUE NO EXISTA LA NOTA
        # SI EXISTE SE CANCELA LA CREACION
        if File.exist?(path)
            warn "La nota '#{title}' ya existe"
            return
        end

        # File.open(path, 'w'){|f| f.write(content)}
        new_note = File.new(path, 'w')
        new_note.puts(content)
        new_note.close

        puts "La nota fue creada con exito!"
        return
    end

    def delete(title, **options)
        book = options[:book]
        extension = "rn"

        # SI LLEGA COMO PARAMETRO UN BOOK SE SELECCIONA EL PATH CON EL BOOK CORRESPONDIENTE
        # SINO EL PATH INDICA EL DIRECTORIO GLOBAL MY_RNS
        path = create_path(book, title)

        path << ".#{extension}"

        if File.exist?(path)
            puts "Esta seguro que quiere eliminar la nota '#{title}.#{extension}'? Y/N"
            value = STDIN.gets.chomp
            if value.downcase == "y"
                File.delete(path) 
                puts "La nota fue eliminada con exito!"
            else
                puts "La nota NO se ha eliminado"
            end
        else 
            puts "La nota que quiere eliminar no existe"
        end 
    end

    def edit(title, **options)
        book = options[:book]
        #   warn "TODO: Implementar modificación de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        # SI LLEGA COMO PARAMETRO UN BOOK SE SELECCIONA EL PATH CON EL BOOK CORRESPONDIENTE
        # SINO EL PATH INDICA EL DIRECTORIO GLOBAL MY_RNS
        path = create_path(book, title)
        extension = "rn"
        path << ".#{extension}"
        
        if File.exist?(path)
            TTY::Editor.open(path)
        else 
            puts "La nota que quiere editar eliminar no existe"
            return
        end

        puts "La nota se edito con exito!"
    end

    def retitle(old_title, new_title, **options)
        book = options[:book]
        extension = "rn"

        # VALIDO QUE EL NUEVO TITULO NO CONTENGA EL CARACTER /
        if !valid_name?(new_title)
            warn "El titulo de la nota no puede contener el caracter '/'"
            return
        end

        # ME GUARDO EL PATH ANTIGUO Y EL NUEVO
        if book != nil
            path = "#{Dir.home}/.my_rns/#{book}/#{old_title}"
            new_path = "#{Dir.home}/.my_rns/#{book}/#{new_title}"   
        else
            path = "#{Dir.home}/.my_rns/global_book/#{old_title}"
            new_path = "#{Dir.home}/.my_rns/global_book/#{new_title}"
        end

        path << ".#{extension}"
        new_path << ".#{extension}"

        # VERIFICO QUE LA NOTA QUE SE QUIERE EDITAR EXISTA, Y QUE EL NUEVO NOMBRE NO EXISTA EN ESE BOOK
        if File.exist?(path)
            if !File.exist?(new_path)
                FileUtils.mv path, new_path
                puts "El titulo de la nota '#{old_title}' ha sido cambiada por '#{new_title}'"
                
            else
                puts "La nota con nombre: '#{new_title}' ya existe en este Libro"
            end                    
        else
            warn "La nota que quiere editar no existe"
        end
    end

    def list(**options)
        book = options[:book]
        global = options[:global]

        # ME GUARDO EL PATH SEGUN LOS PARAMETROS RECIBIDOS
        if global
            path = "#{Dir.home}/.my_rns/global_book"
        elsif book != nil
            path = "#{Dir.home}/.my_rns/#{book}"
        else 
            # SI NO LLEGA NINGUN PARAMETRO RECORRO TODOS LOS LIBROS E IMPRIMO TODAS LAS NOTAS 
            # QUE CONTIENEN LOS LIBROS DE MY_RNS
            path = "#{Dir.home}/.my_rns"
            if !File.exist?(path)
                puts "No se puede listar ya que no existe el book my_rns, intente creando una nota o un nuevo book"
                return 
            end
            Dir.foreach(path) do |f|
                fn = File.join(path, f)
                if f != '.' && f != '..'
                    # puts Dir["#{fn}/*"]
                    # puts Dir.entries(fn) if fn != '.' && fn != '..'
                    if !Dir.empty?(fn)
                        puts "NOTAS DEL BOOK: #{fn}"
                        i = 0
                        Dir.entries(fn).each do |filename|
                            puts "- " + filename unless filename =~ /^..?$/
                        end
                    else
                        puts "NOTAS DEL BOOK: #{fn}"
                        puts "- vacio"
                    end
                end
            end
            return
        end
        if File.exist?(path) 
            if !Dir["#{path}/*"].empty?
                puts "NOTAS DEL BOOK #{path}"   
                Dir.entries(path).each do |filename|
                    puts "- " + filename unless filename =~ /^..?$/
                end
            else
                puts "El libro seleccionado no contiene notas"
            end   
        else
            puts "El libro ingresado no existe"
        end
    end

    def show(title, **options)
        book = options[:book]
        extension = "rn"

        # SI LLEGA COMO PARAMETRO UN BOOK SE SELECCIONA EL PATH CON EL BOOK CORRESPONDIENTE
        # SINO EL PATH INDICA EL DIRECTORIO GLOBAL MY_RNS
        path = create_path(book, title)

        path << ".#{extension}"
        if File.exist?(path)
            File.open(path, "r") do |f|
                f.each_line do |line|
                puts line
                end
            end
        else
            puts "La nota o el libro ingresada no existe"
        end
    end

end