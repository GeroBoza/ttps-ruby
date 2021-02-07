# Trabajo integrador final RAILS

## Instrucciones

Los pasos a seguir para la ejecución del proyecto son:

* Posicionarse en el directorio raiz del proyecto

* Ejecutar el comando `bundle install` para instalar todas las dependencias

* Ejecutar el comando `rails db:migrate` para crear la base de datos

* Ejecutar el comando `rails db:seed` para ejecutar los seeds creados

* Ejecutar `rails s` para levantar la aplicación en `localhost:300`

## Seeds
* Al ejecutar el comando `rails db:seed` se crearán 3 ususarios distintos, con email `seed_userX@gmail.com` y password `123456` con `X = 0/1/2` y dentro de estos 3 usuarios, se crearan books y notes ya predefinidas

## General
* La aplicación se basa en la creación de usuarios, books, y notas. Permitiendo a un usuario crear distintos books que contengan distintas notas. Cada usuario al registrarse tiene un book global inicial que no puede ser editado ni eliminado.

* Utilicé bootstrap para los estilos de la aplicación.

* Tomé la decisión de utilizar la gema recomendada `DEVISE` para la autenticación y autorización del usuario, modificando el método `create` para poder agregarle el `Global Book` a los usuarios que se registren en la aplicación.

* La funcionalidad más importante de la aplicación es la de exportar las `NOTES`, en formato `HTML`. Para esto utilicé una gema llamada `redcarpet` que permite convertir un texto en `MD` a un formato de texto rico, en este caso HTML.<br>
Se generó un botón tanto para la exportación de una `NOTE` en particular, como para la exportación de las notas de un `BOOK` particular, y también para la exportación de todas las notas del usuario.

## Gemas
* <a href="https://github.com/heartcombo/devise" target="_blank">DEVISE</a>
* <a href="https://github.com/vmg/redcarpet" target="_blank">REDCARPET</a>
