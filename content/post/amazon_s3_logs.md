+++
title = "Logs de acceso a websites en Amazon S3"
draft = false
highlight = true
math = false
tags = ["amazon","web","macOS"]
date = "2017-03-04T15:39:03+01:00"

summary = """
Amazon S3 permite generar registros con los accesos a los websites alojados en su infraestructura.
"""

[header]
  image = "posts/Amazon-S3-logs.png"
  caption = ""

+++

Después del [anterior post](/post/amazon_s3/) dedicado al alojamiento de websites estáticos en [Amazon S3](http://docs.aws.amazon.com/AmazonS3/latest/dev/Welcome.html), es el momento de tratar la gestión de los logs o registros de acceso a nuestro website. Posteriormente nos centremos en el [análisis de logs](/post/awstats/) que es fundamental para obtener estadísticas de nuestro website y conocer qué uso, tanto legítimo como inapropiado, se hace de él desde Internet.

*Amazon S3* dispone de una característica denominada [access logging](https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerLogs.html) que permite registrar los accesos que se producen a nuestro website en ficheros de logs. A continuación se describen los pasos para (1) habilitar, (2) purgar y (3) descargar dichos logs a un directorio local.

## 1. Activar el registro de accesos

El registro de accesos o access logging se habilita con unos [sencillos pasos](https://docs.aws.amazon.com/AmazonS3/latest/dev/enable-logging-console.html). De esta forma, con cada petición de acceso se genera un nuevo fichero que se almacena en el [*Bucket*](http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingBucket.html) que hayamos seleccionado para tal fin y que tendrá asociado un nombre único (por ejemplo, `mybucket`). En dichos ficheros se registran los datos de los accesos (`requester`, `bucket name`, `request time`, `request action`, `response status`, `error code`) siguiendo el formato de log que se explica [aquí](https://docs.aws.amazon.com/AmazonS3/latest/dev/LogFormat.html).

## 2. Purgar los ficheros de logs

Es importante considerar que, con el paso del tiempo, el espacio ocupado por estos ficheros de logs irá creciendo. Esto puede llegar a ser un problema no sólo en lo que respecta al volumen sino también económicamente hablando, ya que también se paga por el espacio ocupado. Para evitar sorpresas, lo más recomendable es configurar el [ciclo de vida de objetos](http://docs.aws.amazon.com/AmazonS3/latest/user-guide/setup-lifecycle.html) que posibilita, de forma automática, purgar ficheros o moverlos a [otro almacenamiento](http://docs.aws.amazon.com/AmazonS3/latest/dev/storage-class-intro.html) más barato en base a su tiempo de vida.

## 3. Descargar los ficheros de logs

Para poder trabajar con los ficheros de logs generados, es necesario descargarlos previamente desde donde se encuentren. Esto se puede hacer de forma manual, que no es muy operativo, o automatizada. Para la segunda opción necesitaremos crear un usuario que nos permita usar la [Interfaz de Línea de Comandos (CLI)](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html) de *Amazon Web Services (AWS)* contra la [Interfaz de Programación de Aplicaciones (API)](http://docs.aws.amazon.com/AmazonS3/latest/API/Welcome.html) de *Amazon S3*. Los pasos para poder llevarlo a cabo son los siguientes:

### 3.1. Crear un usuario con permisos de lectura
Antes de poder usar la CLI de AWS contra la API de S3 es indispensable crear un usuario que tenga los permisos suficientes. Esta tarea se realiza a través del [servicio de gestión de acceso e identidad (IAM)](http://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html?icmpid=docs_iam_console) de AWS:

- Crear un grupo y asociarle la política de permisos de sólo lectura (``AmazonS3ReadOnlyAccess``).
- Crear un usuario con el tipo de acceso ``Programmatic access`` y añadirlo al grupo anterior.
- Anotar el identificador de usuario (``Access key ID``) y la contraseña (``Secret access key``) del usuario generado ya que serán necesarios a continuación.

### 3.2. Descargar los logs desde Amazon S3
Para poder descargar los logs en un directorio local (por ejemplo, `mylogs`) usaremos la CLI de AWS que tiene [multitud de comandos](http://docs.aws.amazon.com/cli/latest/userguide/using-s3-commands.html) que permiten automatizar muchas de las tareas. Para el caso de [*macOS*](https://es.wikipedia.org/wiki/MacOS), nos bastará con seguir unos sencillos pasos:

- Instalar la CLI de AWS siguiendo [estas instrucciones](http://docs.aws.amazon.com/cli/latest/userguide/installing.html).
+ Configurarla con el comando *configure*:

```bash
$# aws configure
```

- Responder a las siguientes preguntas:
 - `AWS Access Key ID`. El identificador de usuario.
 - `AWS Secret Access Key`. La contraseña del usuario.
 - `Default region name`. En mi caso, `eu-west-1`.
 - `Default output format`. En mi caso, `None`.
- Crear un directorio donde descargar los logs (por ejemplo, `mylogs`).
- Ejecutar el comando `sync` para descargar los logs, siendo `mybucket` el nombre del bucket donde están los logs:


```bash
$# aws s3 sync s3://mybucket/ mylogs/
```


Por último, será necesario juntar todos los ficheros descargados en uno sólo para facilitar el análisis de los datos. En *macOS* se puede usar un comando como el siguiente:

```bash
$# cat mylogs/* > access.log
```

## Conclusiones
La función *access logging* de *Amazon S3* nos permite registrar cada acceso que se produzca a nuestro website con datos valiosos sobre los mismos como son el solicitante, la respuesta del servidor y los tiempos.

Gracias al análisis de este tipo de información podremos encontrar errores, usos inapropiados, problemas de seguridad e incluso estadísticas sobre nuestros visitantes. Estas cuestiones son las que se abordarán en el siguiente [post](/post/awstats/) junto con el uso de la herramienta [AWStats](http://www.awstats.org).