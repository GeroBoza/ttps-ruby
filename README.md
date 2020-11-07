# Entrega

## Inicio

Al ejecutar cualquiera de los 2 create, tanto de los books como las notes, se crea el directorio my_rns junto con un cuaderno global. En el caso de crear un book, ambos directorios se crean vacios, si se decide arrancar por la creacion de una nota (sin indicar un book por parametro), se crean tanto el directorio my_rns, el directorio global, y la nota creada se almacena en el global_book

## General

Siempre que se intente acceder a una nota o book que no exista el sistema mostrara un mensaje notificando al usuario que esa ruta no existe.
Mantuve la estructura dada de todos los metodos, excepto en el create de las notas, al cual le agregue un parametro opcional `--content` en el cual se puede ingresar un contenido a la nota al momento de crear

## Modulo externo

Tome la decision de crear un modulo externo `Path`, encargado de realizar 3 funciones que la gran mayoria de las Clases definidas compartian.
Lo llame Path ya que todos los metodos estan relacionados con las rutas.

```
    check_my_rns() -> Valida que exista el directorio my_rns y si no existe lo crea
    valid_name?(a_name) -> Valida que el nombre ingresado al momento de crear un book/nota sea valido y no contenga el caracter /
    create_path(book, title) -> Crea la ruta correspondiente
```
