# Entrega 1

## Inicio

Al ejecutar cualquiera de los 2 create, tanto de los books como las notes, se crea el directorio `.my_rns` junto con un `global_book`. En el caso de crear un book, ambos directorios se crean vacíos, si se decide arrancar por la creación de una note (sin indicar un book por parámetro), se crean tanto el directorio `my_rns`, el `global_book`, y la note creada se almacena en el directorio global.

## General

Siempre que se intente acceder a una note o book que no exista el sistema mostrará un mensaje notificando al usuario que esa ruta no existe.
Mantuve la estructura dada de todos los métodos, excepto en el create de las notes, al cual le agregué un parámetro opcional `--content` en el cual se puede ingresar un contenido a la note al momento de crear.

## Modulo externo

Tomé la decisión de crear un modulo externo `Path`, encargado de realizar 3 funciones que la gran mayoría de las Clases definidas compartían.
Lo llamé Path ya que todos los métodos estan relacionados con las rutas.

```
    - check_my_rns() -> Valida que exista el directorio .my_rns y si no existe lo crea
    - valid_name?(a_name) -> Valida que el nombre ingresado al momento de crear un book/note sea valido y no contenga el caracter '/'
    - create_path(book, title) -> Crea la ruta correspondiente
```

---

# Entrega 2

## General

A diferencia de la entrega anterior, teniendo en cuenta las correcciones que se pidieron. Creé una carpeta models, en donde se encuentran los modelos books y notes, quedando las Clases separadas de los comandos brindados por el template.

## Export files

Las notas se exportarán en formato HTML en el mismo directorio de la nota original. El método export se encuentra dentro de la clase `notes.rb`.

Para realizar la exportación de las notas, tomé la decisión de crear un módulo externo `Export`, en el cual me encargo a través del método `export_one_file(path)` de realizar individualmente la exportación de una nota, y a través del método `export_multiple_files(path)` de realizar la exportación de las notas de un directorio en particular.

El método export puede recibir parámetros opcionales, debe recibir al menos 1, pero ninguno es obligatorio.

```
    -> --title
    -> --book
    -> --all
```

-   Si se desea exportar una nota en particular de un book en particular, se deben enviar ambos parámetros (`--title, --book`).
-   Si solo se envía el parámetro `--title`, la nota sera buscada en el book `global_book`.
-   Si se envía el parámetro `--book` unicamente se exportarán todas las notas pertenecientes al book enviado.
-   Por último si se envía el parámetro `--all`, este exportará todas las notas de todos los directorios

### Gema utilizada

La gema que utilicé para realizar la exportación de los archivos es: [github-markdown](https://rubygems.org/gems/github-markdown)
