require_relative "path"
require 'fileutils'
module RN
  module Commands
    module Books
      class Create < Dry::CLI::Command
        include Path
        desc 'Create a book'

        argument :name, required: true, desc: 'Name of the book'

        # example [
        #   '"My book" # Creates a new book named "My book"',
        #   'Memoires  # Creates a new book named "Memoires"'
        # ]

        def call(name:, **)
            
            #VALIDO QUE EL NOMBRE DEL LIBRO NO CONTENGA EL CARACTER '/'
            if !valid_name?(name)
                warn "El titulo del libro no puede contener el caracter '/'"
                return
            end

            # CHEQUEO QUE EXISTA EL DIRECTORIO MY RNS, SINO LO CREO JUNTO CON EL DIRECTORIO GLOBAL DE ARCHIVOS
            check_my_rns()

            # CREO EL PATH DONDE SE VA A CREAR EL DIRECTORIO
            path = "#{Dir.home}/.my_rns/#{name}"

        
            # SI NO EXISTE EL BOOK INDICADO SE CREA
            unless File.directory?(path)
                Dir.mkdir(path)
                puts "El libro fue creado con exito!"
                return
            end

            warn "El libro '#{name}' ya existe"
            return

        end
      end

      class Delete < Dry::CLI::Command
            desc 'Delete a book, options: --global'

            
            argument :name, required: false, desc: 'Name of the book'
            option :global, type: :boolean, default: false, desc: 'Operate on the global book'
            
            example [
                '--global  # Deletes all notes from the global book',
                '"My book" # Deletes a book named "My book" and all of its notes',
                'Memoires  # Deletes a book named "Memoires" and all of its notes'
            ]
            
            def call(name: nil, **options)
                global = options[:global]
                
                # SI RECIBO EL --GLOBAL SE EJECUTA EL FOR QUE ELIMINA LOS ARCHIVOS DEL DIRECTORIO GLOBAL SIN ELIMINAR EL DIRECTORIO
                if global 
                    puts "Esta seguro que quiere eliminar las notas del libro global? Y/N"
                    value = STDIN.gets.chomp
                    if value.downcase == "y"
                        global_path = "#{Dir.home}/.my_rns/global_book"
                        Dir.foreach(global_path) do |f|
                            fn = File.join(global_path, f)
                            File.delete(fn) if f != '.' && f != '..'
                        end
                        puts "Los archivos del libro global han sido eliminados con exito!"
                    else
                        puts "Los archivos del libro global no se han eliminado"    
                    end
                    return
                else
                    # SI NO LLEGA EL --GLOBAL ME GUARDO EL PATH CORRESPONDIENTE A EL LIBRO QUE SE QUIERE ELIMINAR
                    path = "#{Dir.home}/.my_rns/#{name}/"   
                end
                

                # CHEQUEO QUE NO SE INTENTE ELIMINAR EL LIBRO GLOBAL
                if path.match("global_book")
                    warn "El libro global no puede ser eliminado, si desea eliminar su contenido ingrese 'rn books delete --global'"
                    return
                end

                # SI EXISTE EL LIBRO, PREGUNTO SI DESEA ELIMINARLO, SI SE INGRESA Y SE ELIMINA EL LIBRO JUNTO A LAS NOTAS QUE CONTIENE
                if File.directory?(path) 
                    puts "Esta seguro que quiere eliminar el libro '#{name}'? Se eliminaran las notas que contiene.. Y/N"
                    value = STDIN.gets.chomp
                    if value.downcase == "y"
                        FileUtils.rm_rf(path)
                        puts "El Libro y su contenido ha sido eliminado!"                        
                    else
                        puts "Su Libro no se ha eliminado"    
                    end
                else
                    warn "El libro que quiere eliminar no existe!"
                end

            end
      end

      class List < Dry::CLI::Command
        desc 'List books'

        def call(*)
            path = "#{Dir.home}/.my_rns"
            Dir.foreach(path) do |f|
                fn = File.join(path, f)
                puts fn if f != '.' && f != '..'
            end
        end
      end

      class Rename < Dry::CLI::Command
        desc 'Rename a book'
        include Path

        argument :old_name, required: true, desc: 'Current name of the book'
        argument :new_name, required: true, desc: 'New name of the book'

        # example [
        #   '"My book" "Our book"         # Renames the book "My book" to "Our book"',
        #   'Memoires Memories            # Renames the book "Memoires" to "Memories"',
        #   '"TODO - Name this book" Wiki # Renames the book "TODO - Name this book" to "Wiki"'
        # ]

        def call(old_name:, new_name:, **)
            path = "#{Dir.home}/.my_rns"

            # CHEQUEO QUE NO SE QUIERA EDITAR EL LIBRO GLOBAL
            if "#{path}/#{old_name}".match("global_book")
                warn "El libro global no puede ser editado"
                return
            end

            #VALIDO QUE EL NUEVO NOMBRE DEL LIBRO NO CONTENGA EL CARACTER '/'
            if !valid_name?(new_name) 
                warn "El titulo del libro no puede contener el caracter '/'"
                return
            end

            # FALTA CHEQUEAR QUE EXISTA EL LIBRO QUE QUIERO EDITAR

            FileUtils.mv "#{path}/#{old_name}", "#{path}/#{new_name}"
            puts "El libro #{old_name} ha sido renombrado por #{new_name}"
        end
      end
    end
  end
end
