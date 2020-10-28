require_relative "path"
require 'fileutils'
module RN
  module Commands
    module Notes
      class Create < Dry::CLI::Command
        include Path
        desc 'Create a note, options: --book --content'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'
        option :content, type: :string, desc: 'Content of the note'

        # example [
        #   'todo                        # Creates a note titled "todo" in the global book',
        #   '"New note" --book "My book" # Creates a note titled "New note" in the book "My book"',
        #   'thoughts --book Memoires    # Creates a note titled "thoughts" in the book "Memoires"'
        # ]

        def call(title:, **options)
            
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
            if book != nil
                path = "#{Dir.home}/.my_rns/#{book}/#{title}"   
            else
                path = "#{Dir.home}/.my_rns/global_book/#{title}"
            end

            

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
      end

      class Delete < Dry::CLI::Command
        desc 'Delete a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Deletes a note titled "todo" from the global book',
          '"New note" --book "My book" # Deletes a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Deletes a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
            book = options[:book]
            extension = "rn"

            if book != nil
                path = "#{Dir.home}/.my_rns/#{book}/#{title}"   
            else
                path = "#{Dir.home}/.my_rns/global_book/#{title}"
            end

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
      end

      class Edit < Dry::CLI::Command
        desc 'Edit the content a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Edits a note titled "todo" from the global book',
          '"New note" --book "My book" # Edits a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Edits a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          book = options[:book]
          warn "TODO: Implementar modificación de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Retitle < Dry::CLI::Command
        include Path
        desc 'Retitle a note'

        argument :old_title, required: true, desc: 'Current title of the note'
        argument :new_title, required: true, desc: 'New title for the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo TODO                                 # Changes the title of the note titled "todo" from the global book to "TODO"',
          '"New note" "Just a note" --book "My book" # Changes the title of the note titled "New note" from the book "My book" to "Just a note"',
          'thoughts thinking --book Memoires         # Changes the title of the note titled "thoughts" from the book "Memoires" to "thinking"'
        ]

        def call(old_title:, new_title:, **options)
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
      end

      class List < Dry::CLI::Command
        desc 'List notes'

        option :book, type: :string, desc: 'Book'
        option :global, type: :boolean, default: false, desc: 'List only notes from the global book'

        example [
          '                 # Lists notes from all books (including the global book)',
          '--global         # Lists notes from the global book',
          '--book "My book" # Lists notes from the book named "My book"',
          '--book Memoires  # Lists notes from the book named "Memoires"'
        ]

        def call(**options)
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
                Dir.foreach(path) do |f|
                    fn = File.join(path, f)
                    if f != '.' && f != '..'
                        puts Dir["#{fn}/*"]
                    end
                end
                return
            end
            if File.exist?(path)
                if Dir["#{path}/*"].length >0
                    puts Dir["#{path}/*"]   
                else
                    puts "El libro seleccionado no contiene notas"
                end   
            else
                puts "El libro ingresado no existe"
            end
            
        end
      end

      class Show < Dry::CLI::Command
        desc 'Show a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Shows a note titled "todo" from the global book',
          '"New note" --book "My book" # Shows a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Shows a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
            book = options[:book]
            extension = "rn"

            if book != nil
                path = "#{Dir.home}/.my_rns/#{book}/#{title}"   
            else
                path = "#{Dir.home}/.my_rns/global_book/#{title}"
            end

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
    end
  end
end
