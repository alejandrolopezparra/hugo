+++
title = "Generar estadísticas de websites con AWStats"
draft = false
highlight = false
math = false
tags = ["awstats","amazon","web","macOS"]
date = "2017-03-25T16:39:03+01:00"

summary = """
AWStats es un analizador de logs que obtiene estadísticas de uso de servidores web, ftp, streaming y de correo.
"""

[header]
  image = "posts/AWStats.png"
  caption = ""

+++

Después del [anterior post](/post/amazon_s3_logs/), dedicado al registro de accesos a un website alojado en [Amazon S3](http://docs.aws.amazon.com/AmazonS3/latest/dev/Welcome.html) gracias a la característica [access logging](https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerLogs.html), continuamos con lo realmente importante: **el análisis de logs**. Esto es fundamental para obtener estadísticas de nuestro website y conocer qué uso, tanto legítimo como inapropiado, se hace de él desde Internet. Para llevarlo a cabo, se tratará la instalación, configuración y uso de la herramienta de software libre [AWStats](http://www.awstats.org).

*AWStats* es un analizador de logs que genera estadísticas y gráficas en *HTML* sobre el uso de servidores web, ftp, streaming y de correo. Éstos son algunos ejemplos de las estadísticas que es capaz de obtener a partir de los logs:

- Número de visitas, de visitantes únicos y de robots.
- Horas y días de la semana de más uso.
- Países, ciudades y direcciones IP desde los que se accede.
- Navegadores y sistemas operativos usados por los clientes.
- Ranking de páginas más visitadas.
- Errores HTTP.

Está escrito en *Perl* y, por tanto, disponible para múltiples sistemas operativos ([*GNU/Linux*](https://es.wikipedia.org/wiki/GNU/Linux), [*macOS*](https://es.wikipedia.org/wiki/MacOS), [*Windows*](https://es.wikipedia.org/wiki/Microsoft_Windows), etc.).

Básicamente tiene 2 modos de funcionamiento:

- **Common Gateway Interface (CGI)**: para ser integrado con un servidor web como *Apache HTTP Server* o *nginx*.
- **Línea de comandos (CLI)**: para ser ejecutado desde un intérprete de comandos.

En el caso que nos ocupa, se usará desde la *CLI* y sólo para analizar logs de acceso al servidor web de *Amazon S3*. A continuación se describen los pasos para hacerlo funcionar: (1) descargar bases de datos de geolocalización, (2) instalar *Perl*, (3) instalar y configurar *AWStats*, y (4) generar informes con *AWStats*.

## 1. Descargar bases de datos de geolocalización
El primer paso a realizar es descargar la base de datos de geolocalización que se usará para poder obtener el país, sistema autónomo (ASN), organización, región y/o ciudad de cada una de las direcciones IP desde las que visiten nuestro website. *AWStats* soporta tres proveedores de bases de datos:

- [GeoIPFree](http://software77.net/geo-ip/): es gratuita y libre pero sólo proporciona base de datos para el [país](http://software77.net/geo-ip/?DL=4).
- [MaxMind GeoLite](http://dev.maxmind.com/geoip/legacy/geolite/): es gratuita y proporciona bases de datos para el [país](http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz), [ASN](http://download.maxmind.com/download/geoip/database/asnum/GeoIPASNum.dat.gz) y [ciudad](http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz). Se actualizan el primer martes de cada mes.
- [MaxMind GeoIP](http://dev.maxmind.com/geoip/legacy/): es comercial y proporciona bases de datos para el país, ASN, organización, región y ciudad. Se actualizan todas las semanas.

En este caso, optaremos por las 3 bases de datos de *MaxMind GeoLite* así que, una vez descargadas, será necesario descomprimirlas:

`gunzip -f GeoIP.dat.gz GeoIPASNum.dat.gz GeoLiteCity.dat.gz`

## 2. Instalar Perl
La mayoría de los sistemas operativos vienen con el intérprete de *Perl* pre-instalado o disponen de un instalador que facilita la labor. Éste es el caso de *macOS*, que ya cuenta con *Perl* como parte de las utilidades que acompañan al sistema operativo así que no es necesario instalarlo.

Sin embargo, además del intérprete de *Perl*, es necesario disponer del módulo [Geo::IP](http://search.cpan.org/~maxmind/Geo-IP-1.50/lib/Geo/IP.pm) de *MaxMind* para *Perl* de forma que *AWStats* pueda hacer uso de sus bases de datos de geolocalización. En *macOS* y otros sistemas operativos, es tan fácil como ejecutar el comando [cpan](https://metacpan.org/pod/distribution/CPAN/scripts/cpan) que viene con *Perl*.

`cpan Geo::IP`

Si no disponemos de permisos de root/administrador o **por seguridad**, podemos ejecutarlo con un usuario sin privilegios pero, antes, hay que instalar [local::lib](https://metacpan.org/pod/local::lib) (un módulo de *Perl* que permite instalar módulos en directorios locales). Para llevarlo a cabo, lo más recomendable es usar la [técnica bootstrapping](https://metacpan.org/pod/local::lib#The-bootstrapping-technique).


## 3. Instalar y configurar AWStats
Ahora sí, una vez cubiertos todos los requisito previos, llega el momento de descargar *AWStats* desde su [web oficial](http://www.awstats.org/#DOWNLOAD) y descomprimirlo para posteriormente configurarlo según las [instrucciones oficiales](http://www.awstats.org/docs/awstats_setup.html).

Básicamente la configuración consiste en crear un fichero *awstats.$myserver.conf* con todas las opciones de configuración necesarias y donde *$myserver* es el nombre del servidor que aparecerán en los logs. Existen 2 posibilidades para llevarlo a cabo:

- El uso del script *awstats_configure.pl*, que crea el fichero de configuración a partir de las respuestas a las preguntas que interactivamente realiza al usuario. Esta primera alternativa **no es recomendable** a no ser que los logs que se pretendan analizar sean generados por un servidor web *Apache HTTP Server* que esté instalado en la misma máquina que *AWStats*, ya que intenta modificar directamente la configuración de dicho servidor y reiniciarlo después.
- A partir del fichero de configuración de ejemplo que viene *awstats.model.conf*, copiándolo como *awstats.$myserver.conf* y modificando las valores por defecto de las opciones.

Aunque las opciones están bien documentadas en el fichero de configuración de ejemplo y en la [web oficial](http://www.awstats.org/docs/awstats_config.html), las más importantes son las siguientes:

- En el apartado *MAIN SETUP SECTION*
```
LogFile="access.log"
LogFormat="%other %virtualname %time1 %host %extra1 %other %extra2 %url %methodurl %code %extra3 %bytesd %other %extra4 %extra5 %refererquot %uaquot %other"
SiteDomain="www.alejandrolopezparra.es"
HostAliases="localhost 127.0.0.1"
DirIcons="icon"
```

- En el apartado *PLUGINS*
```
LoadPlugin="geoip GEOIP_STANDARD GeoIP.dat"
LoadPlugin="geoip_city_maxmind GEOIP_STANDARD GeoLiteCity.dat"
LoadPlugin="geoip_asn_maxmind GEOIP_STANDARD GeoIPASNum.dat+http://enc.com.au/itools/autnum.php?asn="
LoadPlugin="timezone CET"
```

## 4. Generar informes con AWStats
Una vez que hemos conseguido instalar y configurar todas las herramientas necesarias, es el momento de generar los informes con las estadísticas desde los logs de nuestro website.

El primer paso es construir la base de datos de estadísticas para comprobar si hay algún error, con el comando:

`awstats.pl -config=$myserver -update`

Cuando esto se haya completado correctamente, ya se podrá solicitar a *AWStats* que genere todos los informes posibles con el comando:

`awstats_buildstaticpages.pl -config=$myserver -update -month=all -configdir=$configdir -awstatsprog=$awstatsprog`

donde

- *$myserver* es el nombre del servidor tal y como aparece en los logs.
- *$configdir* es el directorio donde esté el fichero de configuración *awstats.$myserver.conf*.
- *$awstatsprog* es la ruta al comando *awstats.pl*.

El resultado final son una serie de documentos HTML que contienen los informes general y detallados de cada una de las estadísticas que recopila *AWStats*:

- awstats.$myserver.html
- awstats.$myserver.alldomains.html
- awstats.$myserver.allhosts.html
- awstats.$myserver.lasthosts.html
- awstats.$myserver.unknownip.html
- awstats.$myserver.alllogins.html
- awstats.$myserver.lastlogins.html
- awstats.$myserver.allrobots.html
- awstats.$myserver.lastrobots.html
- awstats.$myserver.urldetail.html
- awstats.$myserver.urlentry.html
- awstats.$myserver.urlexit.html
- awstats.$myserver.browserdetail.html
- awstats.$myserver.osdetail.html
- awstats.$myserver.unknownbrowser.html
- awstats.$myserver.unknownos.html
- awstats.$myserver.refererse.html
- awstats.$myserver.refererpages.html
- awstats.$myserver.keyphrases.html
- awstats.$myserver.keywords.html
- awstats.$myserver.errors404.html

## Conclusión
Aunque *AWStats* dispone de buena [documentación oficial](http://www.awstats.org/docs/index.html), no es nada sencillo ni intuitivo usar la herramienta por primera vez debido a la cantidad de opciones que ofrece.

No obstante, una vez superada esa fase, los informes generados por esta herramienta facilitan mucho el análisis de los logs. [Aquí](http://www.nltechno.com/awstats/awstats.pl?config=destailleur.fr) se puede encontrar una demonstración de las estadísticas que puede recopilar.

Por supuesto, *AWStats* no es la única alternativa para generar informes y estadísticas de nuestros logs. De hecho, la propia web oficial recoge una [comparación](http://www.awstats.org/docs/awstats_compare.html) entre algunas de las herramientas que existen.
