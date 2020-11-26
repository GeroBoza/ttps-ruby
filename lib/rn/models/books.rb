require_relative "modules/path"
require 'fileutils'
class Book
    include Path
    def create(name)
        #VALIDO QUE EL NOMBRE DEL LIBRO NO CONTENGA EL CARACTER '/'
            if !valid_name?(name)
                return "El titulo del libro no puede contener el caracter '/'"
                
            end

            # CHEQUEO QUE EXISTA EL DIRECTORIO MY RNS, SINO LO CREO JUNTO CON EL DIRECTORIO GLOBAL DE ARCHIVOS
            check_my_rns()

            # CREO EL PATH DONDE SE VA A CREAR EL DIRECTORIO
            path = "#{Dir.home}/.my_rns/#{name}"

        
            # SI NO EXISTE EL BOOK INDICADO SE CREA
            unless File.directory?(path)
                Dir.mkdir(path)
                return "El libro fue creado con exito!"
                
            end

            return "El libro '#{name}' ya existe"           
    end

    def delete(name, **options) 
        global = options[:global]
        # SI RECIBO EL --GLOBAL SE EJECUTA EL FOR QUE ELIMINA LOS ARCHIVOS DEL DIRECTORIO GLOBAL SIN ELIMINAR EL DIRECTORIO
        global_path = "#{Dir.home}/.my_rns/global_book"
        if !File.directory?(global_path)
            return "No existe el directorio principal my_rns, intente creando un nuevo libro o una nueva nota"
            
        end

        if global 
            puts "Esta seguro que quiere eliminar las notas del libro global? Y/N"
            value = STDIN.gets.chomp
            if value.downcase == "y"
                Dir.foreach(global_path) do |f|
                    fn = File.join(global_path, f)
                    File.delete(fn) if f != '.' && f != '..'
                end
                return "Los archivos del libro global han sido eliminados con exito!"
            else
                return "Los archivos del libro global no se han eliminado"    
            end
            return
        else
            # SI NO LLEGA EL --GLOBAL ME GUARDO EL PATH CORRESPONDIENTE A EL LIBRO QUE SE QUIERE ELIMINAR
            path = "#{Dir.home}/.my_rns/#{name}/"   
        end
        

        # CHEQUEO QUE NO SE INTENTE ELIMINAR EL LIBRO GLOBAL
        if path.match("global_book")
            return "El libro global no puede ser eliminado, si desea eliminar su contenido ingrese 'rn books delete --global'"
            
        end

        # SI EXISTE EL LIBRO, PREGUNTO SI DESEA ELIMINARLO, SI SE INGRESA Y SE ELIMINA EL LIBRO JUNTO A LAS NOTAS QUE CONTIENE
        if File.directory?(path) 
            puts "Esta seguro que quiere eliminar el libro '#{name}'? Se eliminaran las notas que contiene.. Y/N"
            value = STDIN.gets.chomp
            if value.downcase == "y"
                FileUtils.rm_rf(path)
                return "El Libro '#{name}' y su contenido ha sido eliminado!"                        
            else
                return "El Libro '#{name}' no se ha eliminado"    
            end
        else
            return "El libro '#{name}' no existe y no se ha eliminado!"
        end
    end

    def list()
        path = "#{Dir.home}/.my_rns"
        if !File.exist?(path)
            return "No se puede listar ya que no existe el book my_rns, intente creando una nota o un nuevo book"
             
        end
        Dir.foreach(path) do |f|
            fn = File.join(path, f)
            puts fn if f != '.' && f != '..'
        end
    end

    def rename (old_name, new_name)
        path = "#{Dir.home}/.my_rns"

        if !File.directory?(path) 
            return "No existe el directorio principal my_rns, intente creando un nuevo libro o una nueva nota"
            
        end

        old_book_path = "#{path}/#{old_name}"
        # CHEQUEO QUE NO SE QUIERA EDITAR EL LIBRO GLOBAL
        if old_book_path.match("global_book")
            return "El libro global no puede ser editado"
            
        end

        #VALIDO QUE EL NUEVO NOMBRE DEL LIBRO NO CONTENGA EL CARACTER '/'
        if !valid_name?(new_name) 
            return "El titulo del libro no puede contener el caracter '/'"
            
        end

        # CHEQUEO QUE EXISTA EL LIBRO QUE QUIERO RENOMBRAR
        if !File.directory?(old_book_path) 
            return "El libro que quiere renombrar no existe"
            
        end

        #CHEQUEO QUE EL NUEVO NOMBRE NO EXISTA COMO UN BOOK
        if File.directory?("#{path}/#{new_name}") 
            return "El libro '#{new_name}' ya existe, pruebe con otro nombre"
            
        end

        FileUtils.mv "#{path}/#{old_name}", "#{path}/#{new_name}"
        return "El libro #{old_name} ha sido renombrado por #{new_name}"
    end


end