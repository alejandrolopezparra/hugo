+++
title = "Alojar websites estáticos en Amazon Simple Storage Service (S3)"
draft = false
highlight = false
math = false
tags = ["amazon","hugo","web"]
date = "2017-02-11T12:00:00+01:00"

summary = """
Amazon S3 es un servicio web que ofrece una infraestructura de almacenamiento de datos escalable, fiable y de baja latencia. 
"""

[header]
  image = "posts/Amazon-S3.png"
  caption = ""

+++

Como continuación al [primer post](/post/hugo/) en el que hablaba de [Hugo](https://gohugo.io), el framework usado para la creación de esta web, me gustaría seguir comentando otra de las tecnologías en las que se apoya. En esta ocasión es el turno del servicio [Amazon Simple Storage Service (S3)](http://docs.aws.amazon.com/AmazonS3/latest/dev/Welcome.html) que pertenece a la plataforma de servicios en la nube [Amazon Web Services (AWS)](https://aws.amazon.com/es/what-is-aws/).

*Amazon S3* es un servicio de pago para almacenamiento en la nube al estilo de [Dropbox](https://www.dropbox.com), [Google Drive](https://drive.google.com) o [Microsoft OneDrive](https://onedrive.live.com/about/es-es/). Además de almacenar ficheros y directorios, **permite alojar websites de contenido estático**, es decir, webs que se basan en *HyperText Markup Language* (*HTML*), *JavaScript* (*JS*) y *Cascading Style Sheets* (*CSS*). El contenido no es generado dinámicamente en cada solicitud que se realiza al servidor y, por tanto, no son necesarios ni servidores de aplicaciones ni de bases de datos. Sólo se requiere un servidor web que sirva el contenido según se le vaya solicitando. Afortunadamente, gracias a tecnologías que se ejecutan en el lado del cliente como *JS* y *CSS*, se puede conseguir cierto dinamismo en cómo se muestra el contenido aunque éste sea servido de forma estática.

A continuación se describen los 2 pasos que hay que realizar para poder publicar una web estática: (1) alojar el website y (2) asociar un dominio.

## 1. Alojar un website estático en Amazon S3

La capacidad de alojamiento de webs estáticas de *Amazon S3* está explicada en detalle [aquí](https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html) pero, en resumen, nos permite lo siguiente:

1. Crear un contenedor o depósito denominado [*Bucket*](http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingBucket.html) que está físicamente en una [región](http://docs.aws.amazon.com/general/latest/gr/rande.html#s3_website_region_endpoints) o CPD de *Amazon*. Los *Buckets* tienen que tener un **nombre único** en una región y ese nombre debe coincidir con el dominio *DNS* que pretandamos registrar posteriormente.
2. Almacenar los ficheros *HTML* y demás recursos webs asociados en dicho *Bucket*.
3. Publicar el *Bucket* a través de un [*Endpoint*](http://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteEndpoints.html). Un *Endpoint* apunta a un *Bucket* concreto que se encuentra en una región en particular. En mi caso es [www.alejandrolopezparra.es.s3-website-eu-west-1.amazonaws.com](http://www.alejandrolopezparra.es.s3-website-eu-west-1.amazonaws.com)
4. Configurar cuál es la página [index](https://docs.aws.amazon.com/AmazonS3/latest/dev/IndexDocumentSupport.html) (página que se cargará por defecto) y la que se muestra en caso de [error](https://docs.aws.amazon.com/AmazonS3/latest/dev/CustomErrorDocSupport.html).
5. Activar los [ficheros de logs](https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerLogs.html) para registrar los accesos que se produzcan al servidor. Más información sobre esto en el post dedicado a los [logs de Amazon S3](/post/amazon_s3_logs/).

También contamos con un [asistente o guía rápida](https://console.aws.amazon.com/quickstart-website/new) que nos facilita el proceso de alojamiento de un nuevo website.

## 2. Asociar un dominio propio

Una vez tenemos nuestro website alojado en un *Bucket* y lo hemos publicado en un *Endpoint*, es el momento de asociarle un nombre de un dominio propio, por ejemplo [www.alejandrolopezparra.es](http://www.alejandrolopezparra.es).

Para lograrlo es necesario **registrar el dominio** en un registrador de dominios y **crear un nombre en ese dominio** a través de un servicio DNS que apunte al Endpoint definido anteriormente mediante lo que se conoce como alias. De esta forma, cuando un navegador web intente resolver dicho nombre, recibirá como respuesta el endpoint donde tenemos alojado nuestro website. Lo habitual es crear un alias para el subdominio `www` aunque en algunos proveedores *DNS* también es posible crear un alias para el dominio raíz. Es muy importante tener en cuenta que **cada alias tiene que apuntar a un *Endpoint* concreto** y el **nombre del alias debe coincidir con el nombre del _Endpoint_**.

Existen multitud de registradores de dominios y muchos de ellos también proporcionan servicios *DNS*. *Amazon* ofrece estos servicios a través de [Amazon Route 53](https://aws.amazon.com/es/route53/) y dispone de una [guía](https://docs.aws.amazon.com/AmazonS3/latest/dev/website-hosting-custom-domain-walkthrough.html#root-domain-walkthrough-switch-to-route53-as-dnsprovider) en la que explican cómo llevarlo a cabo. Otro prestador muy conocido de este tipo de servicios es [Dyn](http://dyn.com). En mi caso, uso [GoDaddy](https://es.godaddy.com) para ambas cosas aunque tiene la pega de no permitir alias del dominio raíz por lo que sólo se pueden usar en los subdominios.

## Conclusiones
*Amazon S3* permite el alojamiento de websites estáticos de forma fácil y con precios económicos, especialmente el primer año que es [gratuito](https://aws.amazon.com/es/free/). A partir de ahí, el modelo de negocio se basa en pago por uso de almacenamiento y trasferencia de datos (tanto de subida como de descarga). Para webs personales o con poco tráfico es idóneo porque la factura es muy baja si no hay muchas visitas. Incluso te permite definir alertas cuando el sistema prevee que se pueden superar ciertos umbrales.

Existen otras alternativas que merecerían la pena explorar para valorar la que mejor se adapta a las necesidades de cada uno:

- [Google Cloud Storage](https://cloud.google.com/storage/) con su [guía](https://cloud.google.com/storage/docs/hosting-static-website). De pago.
- [Github Pages](https://pages.github.com) que dispone de un [tutorial para Hugo](https://gohugo.io/tutorials/github-pages-blog/). Gratuito.
- [BitBucket](https://bitbucket.org/) que también tiene un [tutorial para Hugo](https://gohugo.io/tutorials/hosting-on-bitbucket/). Gratuito.
- [GitLab](https://about.gitlab.com/) que también ofrece un [tutorial para Hugo](https://gohugo.io/tutorials/hosting-on-gitlab/). Gratuito.
