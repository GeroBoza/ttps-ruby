# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

3.times do |i|
    u = User.create! :email => "seed_user#{i}@gmail.com" , :password => '123456', :password_confirmation => '123456'
    global = u.books.create(user_id: u.id,name:"Global Book")
    global.notes.create(book_id: global.id , title: "seed notes" , content: "## Uso de `rn`

Para ejecutar el comando principal de la herramienta se utiliza el script `bin/rn`, el cual
puede correrse de las siguientes manera:

```bash
$ ruby bin/rn [args]
```

O bien:

```bash
$ bundle exec bin/rn [args]
```

O simplemente:

```bash
$ bin/rn [args]
```

Si se agrega el directorio `bin/` del proyecto a la variable de ambiente `PATH` de la shell,
el comando puede utilizarse sin prefijar `bin/`:

```bash
# Esto debe ejecutarse estando ubicad@ en el directorio raiz del proyecto, una única vez
# por sesión de la shell
$ export PATH='$(pwd)/bin:$PATH'
$ rn [args]
```

> Notá que para la ejecución de la herramienta, es necesario tener una versión reciente de
> Ruby (2.5 o posterior) y tener instaladas sus dependencias, las cuales se manejan con
> Bundler. Para más información sobre la instalación de las dependencias, consultar la
> siguiente sección ('Desarrollo').")

    3.times do |f|
        book = u.books.create(user_id: u.id,name:"book#{f}")
        3.times do |g|
            book.notes.create(book_id: book.id , title: "titulo #{g}" , content: "# README
                This README would normally document whatever steps are necessary to get the
                application up and running.
                
                Things you may want to cover:
                
                * Ruby version
                
                * System dependencies
                
                * Configuration
                
                * Database creation
                
                * Database initialization
                
                * How to run the test suite
                
                * Services (job queues, cache servers, search engines, etc.)
                
                * Deployment instructions
                ")
        end
    end
end