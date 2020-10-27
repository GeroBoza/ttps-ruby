require_relative "path"
module RN
  module Commands
    module Notes
      class Create < Dry::CLI::Command
        include Path
        desc 'Create a note'

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

            if title.match("/")
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

            # VALIDO QUE NO EXISTA EL ARCHIVO
            # SI EXISTE SE CANCELA LA CREACION
            if File.exist?(path)
                warn "El archivo '#{title}' ya existe"
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
          warn "TODO: Implementar borrado de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
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
          warn "TODO: Implementar cambio del título de la nota con título '#{old_title}' hacia '#{new_title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
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
          warn "TODO: Implementar listado de las notas del libro '#{book}' (global=#{global}).\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
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
          warn "TODO: Implementar vista de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end
    end
  end
end
