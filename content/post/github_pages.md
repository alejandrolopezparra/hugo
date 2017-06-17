+++
title = "Alojar websites estáticos en GitHub Pages"
draft = false
highlight = false
math = false
tags = ["github","amazon","hugo","web"]
date = "2017-05-27T12:00:00+02:00"
summary = """
GitHub Pages es un servicio gratuito de alojamiento de websites estáticos que rivaliza con Amazon S3. 
"""

[header]
  image = "posts/GitHub-Pages.png"
  caption = ""

+++

Como alternativa a [Amazon Simple Storage Service (S3)](http://docs.aws.amazon.com/AmazonS3/latest/dev/Welcome.html) que [ya traté](/post/amazon_s3/), a continuación abordaré el servicio [GitHub Pages](https://pages.github.com/) que pertenece a la plataforma [GitHub](https://github.com/) de desarrollo colaborativo para alojar proyectos utilizando el sistema de control de versiones [*Git*](https://es.wikipedia.org/wiki/Git).

*GitHub Pages* es un servicio gratuito que **permite alojar websites de contenido estático**, es decir, webs que se basan en *HyperText Markup Language* (*HTML*), *JavaScript* (*JS*) y *Cascading Style Sheets* (*CSS*). El contenido no es generado dinámicamente en cada solicitud que se realiza al servidor y, por tanto, no son necesarios ni servidores de aplicaciones ni de bases de datos. Sólo se requiere un servidor web que sirva el contenido según se le vaya solicitando. Afortunadamente, gracias a tecnologías que se ejecutan en el lado del cliente como JS y CSS, se puede conseguir cierto dinamismo en cómo se muestra el contenido aunque éste sea servido de forma estática.

A continuación se describen sus características y los pasos que hay que realizar para poder publicar una web estática en *GitHub Pages* (alojar el website y asociar un dominio).

## 1. Características de *GitHub Pages*
*GitHub Pages* dispone de varios [tipos de cuentas o planes](https://help.github.com/articles/github-s-billing-plans/):

* [Privada](https://github.com/pricing): tiene un coste mensual que permite que los ficheros se alojen de forma privada entre otras ventajas.
* Gratuita: todos los ficheros alojados son públicos.

Se contemplan **3 tipos de páginas web** que pueden ser alojadas en repositorios de *GitHub*:

* Personal.
* De organización.
* De proyectos.

Se explican las diferencias entre estos tipos de páginas web en este [artículo oficial](https://help.github.com/articles/user-organization-and-project-pages/).

Los **límites de uso** de *GitHub Pages* son los siguientes:

* Las páginas web no pueden ocupar más de 1 GygaByte.
* El ancho de banda que puede consumir está limitado a 100 GygaBytes al mes.
* El número de actualizaciones está limitado a 10 por hora.

Dispone de **estadísticas básicas** de tráfico y red que nos permiten saber el uso que se está haciendo de la web. No obstante, no permite el registro de logs y, por tanto, no se pueden obtener estadísticas avanzadas como la información de los visitantes (direcciones IP, países, etc.) o las páginas más visitadas. La alternativa sería contar con un servicio de terceros como [*Google Analytics*](https://analytics.google.com). 

Por otro lado, dispone de algunas **opciones avanzadas**:

* Crear [páginas de error personalizadas](https://help.github.com/articles/creating-a-custom-404-page-for-your-github-pages-site/).
* Tiene [soporte para cientos de tipos MIME](https://help.github.com/articles/mime-types-on-github-pages/).
* Usar [submódulos dentro de las páginas](https://help.github.com/articles/using-submodules-with-pages/).

## 2. Alojar un website estático en *GitHub Pages*
La capacidad de alojamiento de webs estáticas de *GitHub Pages* está explicada de forma sencilla en [este tutorial oficial](https://pages.github.com/).

El proceso para un website personal sería el siguiente:

1. **Registrar o acceder** a una [cuenta de *GitHub*](https://github.com/login).
2. **Crear un contenedor de ficheros** denominado *Repository*. Para que pueda usarse para alojar un website, tiene que tener un nombre especial *nombre.github.io*, donde *nombre* debe coincidir con el nombre de usuario de la cuenta de *GitHub*, que servirá como *Endpoint*. En mi caso es *alejandrolopezparra.github.io*.
3. Aunque *GitHub* permite **crear y editar contenido** directamente a través de la web de *GitHub*, lo más conveniente es usar alguna herramienta que facilite esta tarea, como [Hugo](https://gohugo.io/) de la que [ya hablamos](/post/hugo/). Para ello, previamente sería necesario clonar el *Repository* recién creado en local con un [cliente *Git*](https://git-scm.com/). Si se usa el cliente de línea de comandos, habría que ejecutar:

    `git clone https://github.com/nombre/nombre.github.io`

3. Una vez tengamos generados los ficheros HTML y demás recursos webs asociados, es el momento de **alojar el contenido estático** en el *Repository* creado con un cliente *Git*. Si se usa el cliente de línea de comandos, habría que ejecutar los siguientes:

    `git add --all`

    `git commit -m "Initial commit"`

    `git push -u origin master`

Sólo con esos tres pasos, ya tendríamos nuestra página web personal accesible a través de un *Endpoint* seguro *HTTPS*://nombre.github.io donde *nombre* se corresponde con el nombre de usuario de la cuenta de *GitHub*. En mi caso, es [https://alejandrolopezparra.github.io](https://alejandrolopezparra.github.io).

Para el caso concreto de *Hugo*, contamos con un [tutorial](https://gohugo.io/tutorials/github-pages-blog/) que trata el despliegue en *GitHub Pages* de páginas web basadas en *Hugo* tanto personales como de organizaciones y también de proyectos.

## 3. Asociar un dominio propio
Una vez tenemos nuestro website alojado en un *Repository* y publicado en un *Endpoint* de *GitHub*, es el momento de que podamos asociarle un nombre de un dominio personalizado como, por ejemplo, [www.alejandrolopezparra.es](http://www.alejandrolopezparra.es). El único inconveniente de este paso es que perderemos la opción de usar *HTTPS* ya que *GitHub Pages* sólo puede usarlo con el domino *github.io*[^Cloudflare].

[^Cloudflare]: Habría una alternativa que es usar [*GitHub Pages* con *Cloudflare*](https://www.goyllo.com/github/pages/free-cloudflare-ssl-for-custom-domain/).

Para lograrlo es necesario lo siguiente:

1. **Registrar el dominio** en un registrador de dominios.
2. **Crear un nombre en ese dominio** a través de un servicio *DNS* que apunte al *Endpoint* definido anteriormente mediante lo que se conoce como alias o [*registro CNAME*](https://en.wikipedia.org/wiki/CNAME_record).
3. **Configurar el nombre de dominio** en *GitHub Pages* en las propiedades del *Repository* tal y como se indica [aquí](https://help.github.com/articles/adding-or-removing-a-custom-domain-for-your-github-pages-site/).

De esta forma, cuando un navegador web intente resolver dicho nombre, recibirá como respuesta el *Endpoint* donde tenemos alojado nuestro website. Lo habitual es [crear un alias para el subdominio *www*](https://help.github.com/articles/setting-up-a-www-subdomain/) aunque en algunos proveedores DNS también es posible [crear un alias para el dominio raíz](https://help.github.com/articles/setting-up-an-apex-domain/). Gracias a esto, se puede acceder tanto a [www.alejandrolopezparra.es](http://www.alejandrolopezparra.es) como a [alejandrolopezparra.es](http://alejandrolopezparra.es), siendo habitualmente este último una redirección al primero.

En el caso de *GitHub Pages*, si nuestro proveedor *DNS* no permite alias para el dominio raíz, tenemos la opción de conseguir el mismo efecto [a través de registros de tipo A](https://help.github.com/articles/setting-up-an-apex-domain/#configuring-a-records-with-your-dns-provider).

Existen multitud de registradores de dominios y muchos de ellos también proporcionan servicios *DNS*. *Amazon* ofrece estos servicios a través de [*Amazon Route 53*](https://aws.amazon.com/es/route53/) y dispone de una [guía](https://docs.aws.amazon.com/AmazonS3/latest/dev/website-hosting-custom-domain-walkthrough.html#root-domain-walkthrough-switch-to-route53-as-dnsprovider) en la que explican cómo llevarlo a cabo. Otro prestador muy conocido de este tipo de servicios es [*Dyn*](http://dyn.com). En mi caso, uso [*GoDaddy*](https://es.godaddy.com) para ambas cosas aunque tiene la pega de no permitir alias del dominio raíz.

## 4. Conclusión
*GitHubs Pages* permite el alojamiento de websites estáticos de forma fácil y gratuita. Para webs personales o con un tráfico moderado es idóneo ya que tiene unos límites de uso suficientemente elevados.

Desde mi punto de vista, su mayor inconveniente es que no dispone de estadísticas avanzadas de uso ni permite registrar los logs de las visitas para obtenerlas sin la necesidad de un servicio de estadísticas externo.

En cualquier caso, *Amazon S3* y *GitHub Pages* no son las únicas alternativas:

- [Google Cloud Storage](https://cloud.google.com/storage/) con su [guía](https://cloud.google.com/storage/docs/hosting-static-website). De pago.
- [BitBucket](https://bitbucket.org/) que también tiene un [tutorial para Hugo](https://gohugo.io/tutorials/hosting-on-bitbucket/). Gratuito.
- [GitLab](https://about.gitlab.com/) que también ofrece un [tutorial para Hugo](https://gohugo.io/tutorials/hosting-on-gitlab/). Gratuito.
