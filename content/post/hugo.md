+++
title = "Crear websites estáticos con Hugo"
draft = false
highlight = false
math = false
tags = ["hugo","web"]
date = "2017-01-28T15:00:00+01:00"

summary = """
Hugo es un framework para la creación de websites de contenido estático. 
"""

[header]
  image = "posts/Hugo.png"
  caption = ""
+++

Como no podía ser de otra manera, inauguro esta web con un primer post que va dedicado a la tecnología que he usado para crear este sitio.

[*Hugo*](https://gohugo.io) es un framework que permite crear websites a base de contenido estático (*HTML*, *JavaScript*, *CSS*, ...), es decir, no se sustenta en el uso de servidores de aplicaciones o bases de datos. Lo contrario de lo que ocurre con los sistemas de gestión de contenidos o *CMS* habituales los cuales suelen estar basados en contenido dinámico: *WordPress*, *Drupal*, *Joomla!*, *Dokuwiki*, etc. Por suspuesto, esto, tiene sus ventajas e inconvenientes.

## Ventajas:

- **Simplicidad**: sólo se necesita un servidor web que sirva las páginas webs y el resto de contenido estático, no hay servidores de bases de datos ni de aplicaciones.
- **Ahorro económico**: no se requiere un servidor muy potente ya que las peticiones que tiene que servir son más ligeras, no hay accesos a bases de datos ni procesamientos complejos en el lado del servidor.
- **Seguridad**: como no se tiene que realizar procesamiento de los datos de entrada ni consultas a otros servicios en backend, la posibilidad de explotar alguna vulnerabilidad en el lado del servidor se reduce drásticamente.
- **Multiplataforma**: es posible usar casi cualquier sistema operativo ([*Windows*](https://es.wikipedia.org/wiki/Windows), [*GNU/Linux*](https://es.wikipedia.org/wiki/GNU/Linux), [*macOS*](https://es.wikipedia.org/wiki/MacOS), [*FreeBSD*](https://es.wikipedia.org/wiki/FreeBSD), etc.) y arquitectura ([*x64*](https://es.wikipedia.org/wiki/X86-64), [*x86*](https://es.wikipedia.org/wiki/X86), [*ARM*](https://es.wikipedia.org/wiki/Arquitectura_ARM)).
- **Multihosting**: al estar basado en contenido estático, se puede usar cualquier hosting web o *CDN* (*Amazon S3*, *GitHub Pages*, *Dropbox*, *Heroku*, *Google Cloud Storage*, *Amazon CloudFront*, ...).
- **Personalización**: soporta el uso de [*themes*](http://themes.gohugo.io/) o temas que permiten personalizar el aspecto del site de forma fácil manteniendo el contenido.

## Inconvenientes:

- **Funcionalidad limitada**: aunque con *JS* se puede implementar mucha funcionalidad en el lado del cliente, no es posible resolverlo todo. Hay cosas que sólo se pueden realizar en el lado del servidor: gestión de usuarios, comentarios, cestas de la compra, formularios de contacto, etc.
- **Gestión de contenidos simple**: no está pensado para que haya varios autores ni permite una gestión de contenidos compleja.
- **Curva de aprendizaje**: está basado en el lenguaje de marcado [*Markdown*](https://es.wikipedia.org/wiki/Markdown) para la creación de contenido. No obstante, existen interfaces de usuarios (UI) que facilitan la creación de contenido en este lenguaje.

## Conclusiones
Hugo es idóneo para crear páginas personales, blogs, portfolios y webs de documentación especialmente cuando sólo hay un autor pero no para sites más complejos. Hay mucha [documentación](https://gohugo.io/overview/introduction/) en la web oficial incluyendo una [guía para principiantes](https://gohugo.io/overview/quickstart/).

En mi caso, he optado por personalizar la apariencia de [*Hugo*](https://gohugo.io) con el tema [*academic*](http://themes.gohugo.io/academic/) por su simplicidad y estilo minimalista. En el [próximo post](/post/amazon_s3/) abordaré el alojamiento del website con [*Amazon S3*](https://aws.amazon.com/es/s3/) por su facilidad de uso y precio reducido.
