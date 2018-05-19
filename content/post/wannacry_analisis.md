+++
title = "WannaCry, el ransomworm más mediático (I)"
draft = true
highlight = true
math = false
tags = ["ransomware","worm","ciberataque","seguridad"]
date = "2017-06-03T12:00:00+02:00"
summary = """
Análisis de *WannaCry*, un *ransomware* que ha secuestrado los datos de cientos de miles de ordenadores en todo el mundo. 
"""

[header]
  image = "posts/WannaCry-Decrypt0r.png"
  caption = ""

+++

El **viernes 12 de mayo de 2017**, a media mañana, los medios generalistas se hicieron eco de un ciberataque de tipo [*ransomware*](https://es.wikipedia.org/wiki/Ransomware) que estaba afectando a grandes compañias en España y otros países. Esta noticia fue cabecera de la mayoría de los informativos, telediarios y programas de variadades, durante todo el fin de semana y algunos días después, a nivel mundial. Me atrevería a decir que ha sido **el ciberataque con más repercusión en los medios** de toda la historia.

Aunque ha recibido distintos nombres desde que salió a la luz (*WCry*, *WanaCry*, *Wana Decrypt0r*, *WannaCrypt0r*, *WannaCrypt*) parece que el que finalmente ha conseguido mayor aceptación es el de ***WannaCry***, que hace alusión a que los afectados **quieren llorar** por haber perdido todos sus datos.

A continuación se tratarán el análisis de las características técnicas del *malware*, las medidas de prevención y la recuperación.

## Análisis de *WannaCry*
*WannaCry* es un malware para diferentes versiones del sistema operativo *Microsoft Windows* que combina varios comportamientos maliciosos:

- [***Ransomware***](https://es.wikipedia.org/wiki/Ransomware): secuestra los documentos digitales de los equipos y pide un rescate económico para recuperarlos.
- [***Worm***](https://es.wikipedia.org/wiki/Worm): se propaga automáticamente para infectar a la mayor cantidad de equipos posibles.

Éstas son algunas de las fuentes en las que me he basado para el análisis de este *malware*:

- [CERT de Seguridad e Industria](https://www.certsi.es/blog/ransomware-wannacry-responsable-ciberataque-mundial).
- [MalwareBytes](https://blog.malwarebytes.com/threat-analysis/2017/05/the-worm-that-spreads-wanacrypt0r/).
- [Wannacrypt0r-FACTSHEET](https://gist.github.com/rain-1/989428fa5504f378b993ee6efbc0b168).
- [Cisco Talos](http://blog.talosintelligence.com/2017/05/wannacry.html).
- [Kryptos Logic](https://blog.kryptoslogic.com/malware/2017/05/29/two-weeks-later.html).
- [EndGame](https://www.endgame.com/blog/technical-blog/wcrywanacry-ransomware-technical-analysis).
- [Forcepoint](https://blogs.forcepoint.com/security-labs/wannacry-post-outbreak-analysis).
- [BAE Systems](https://baesystemsai.blogspot.com.es/2017/05/wanacrypt0r-ransomworm.html).
- [Microsoft](https://blogs.technet.microsoft.com/mmpc/2017/05/12/wannacrypt-ransomware-worm-targets-out-of-date-systems/).
- [G Data](https://www.gdatasoftware.com/blog/2017/05/29751-wannacry-ransomware-campaign).
- [The Hacker News](http://thehackernews.com/2017/05/how-to-wannacry-ransomware.html).
- [SonicWall](https://blog.sonicwall.com/2017/06/did-wannacry-perpetrators-ever-get-their-ransom/).

### *Worm*
Posee un módulo que se encarga de **propagarse por la red sin intervención del usuario** para infectar otros equipos e inyectarse en ellos.

Para conseguirlo, usa un [*exploit*](https://es.wikipedia.org/wiki/Exploit) conocido como [*EternalBlue*](https://es.wikipedia.org/wiki/EternalBlue) que instala un [*backdoor*](https://es.wikipedia.org/wiki/Puerta_trasera) denominado [DoublePulsar](https://en.wikipedia.org/wiki/DoublePulsar) a través del cuál se instala el *malware*. Tanto *EternalBlue* como *DoublePulsar* son herramientas desarrolladas, suspuestamente para la [Agencia de Seguridad de los Estados Unidos (NSA)](https://es.wikipedia.org/wiki/Agencia_de_Seguridad_Nacional), por el grupo de hackers [Equation Group](https://en.wikipedia.org/wiki/Equation_Group).

*EternalBlue* es una herramienta que aprovecha la vulnerabilidad [cve-2017-0144](https://www.certsi.es/alerta-temprana/vulnerabilidades/cve-2017-0144) del protocolo [*Server Message Block 1.0* (*SMBv1*)](https://es.wikipedia.org/wiki/Server_Message_Block) de los sistemas operativos *Windows*. Aunque esta vulnerabilidad afecta a todos los equipos con *Windows XP/Vista/7/8/10* y *Windows Server 2003/2008/2012/2016* que no estén convenientemente actualizados, los análisis realizados demuestran que **_Windows XP_, _Windows 10_ y _Windows Server 2016_ no se infectan**. Esto se debe a que el *exploit* no está diseñado para estos sistemas operativos y falla al intentar aprovechar la vulnerabilidad.

Una vez infectado un equipo, el *malware* comprueba si puede conectarse a esta página web

`www[.]iuqerfsodp9ifjaposdfjhgosurijfaewrwergwea[.]com`

- En caso de que pueda acceder, se desactiva y no realiza ninguna acción en el equipo.
- En caso de que no pueda conectarse, intenta propagarse a otros equipos y ejecuta el componente *ransomware*.

Debido a este comportamiento, se conoce a esa página como ***kill switch*** o interruptor de apagado de emergencia ya que permite detener la propagación de este *malware*.

### *Ransomware*
El proceso realizado por el componente *ransomware*, una vez un equipo ha sido infectado, es (1) preparar el sistema, (2) cifrar los ficheros y (3) solicitar un rescate.

#### Preparación
Posee un módulo que **busca** documentos ofimáticos, imágenes, archivos multimedia, bases de datos y otros tipos de ficheros comunes, tanto en el propio equipo como en todas las unidades que tenga conectadas por red. El listado de extensiones de ficheros que intenta localizar es grande, más de 150 (.doc, .pdf, .jpg, .png, .avi, ...), pero ignora deliberadamente los ficheros necesarios para el correcto funcionamiento del Sistema Operativo.

#### Cifrado
Para secuestrar los ficheros, utiliza algoritmos de [criptografía asimétrica o de dos claves](https://es.wikipedia.org/wiki/Criptograf%C3%ADa_asim%C3%A9trica) (privada y pública), que son más seguros, combinados con [criptografía simétrica o de clave secreta](https://es.wikipedia.org/wiki/Criptograf%C3%ADa_sim%C3%A9trica), que son más rápidos.

De forma resumida, podríamos decir que **cada fichero es cifrado con una clave aleatoria distinta que solamente pueden averiguar los atacantes**. A continuación se dan detalles técnicos del proceso de cifrado que ayudan a entenderlo.

##### Descripción técnica del cifrado
Lo primero que realiza es la **generación de claves asimétricas** robustas `RSA-2048` que usará posteriormente:

1. Extrae una clave pública (*PuK*) que lleva en su código y que tiene asociada una clave privada (*PrK*) que no se incluye.
1. Genera aleatoriamente un nuevo par de claves pública (*PuKN*) y privada (*PrKN*).
2. Guarda *PuKN* en el fichero `00000000.pky`.
3. Guarda *PrKN* en el fichero `00000000.eky`, cifrado con la clave pública *PuK*, de manera que sólo es descifrable con *PrK*.
4. Destruye las claves de la memoria para que no sean recuperables.

Después, para cada fichero localizado, lo **cifra con una clave simétrica** `AES-128-CBC` distinta en cada caso:

1. Genera aleatoriamente una clave secreta (*Sec*).
2. Realiza una copia cifrada del fichero original con *Sec* y le añade la extensión `.WNCRY`.
3. Adjunta *Sec*, cifrada con *PuKN*, a la cabecera del fichero. De esta forma, sólo es descifrable si se conoce *PrKN* que a su vez ha sido cifrada con *PuK*.
4. Borra de forma segura el fichero original para que no se pueda restaurar.
5. Destruye la clave secreta de memoria para que no sea recuperable.

De esta forma, cada fichero es cifrado con una clave simétrica distinta *Sec* que está protegida por una clave asimétrica *PrKN* que sólo se puede recuperar con la clave asimétrica *PrK* que tienen los creadores de *WannaCry*.

#### Rescate
Una vez cifrados todos los ficheros, el *malware* cambia el fondo de escritorio por un mensaje que avisa de que todos los ficheros han sido cifrados. De la misma forma, muestra una ventana con las intrucciones para pagar **300 $** en [*Bitcoins* (*BTC*)](https://es.wikipedia.org/wiki/Bitcoin) mediante una trasferencia a una de las siguientes carteras de *Bitcoins*:

- [12t9YDPgwueZ9NyMgw519p7AA8isjr6SMw](https://blockchain.info/address/12t9YDPgwueZ9NyMgw519p7AA8isjr6SMw).
- [115p7UMMngoj1pMvkpHijcRdfJNXj6LrLn](https://blockchain.info/address/115p7UMMngoj1pMvkpHijcRdfJNXj6LrLn).
- [13AM4VW2dhxYgXeQepoHkHSQuy6NgaEb94](https://blockchain.info/address/13AM4VW2dhxYgXeQepoHkHSQuy6NgaEb94).

También se muestra un contador de tiempo que indica que esta cantidad se verá incrementada a **600 $** si no se realiza el pago antes de **3 días**. Por si fuera poco, amenaza con que **los datos no serán recuperables** en caso de no realizar el pago antes de **7 días**. 

En paralelo, el *malware* envía, a través de la red de anonimato [*Tor*](https://es.wikipedia.org/wiki/Tor_(red_de_anonimato)), el archivo `00000000.eky`, que contiene la clave privada cifrada necesaria para recuperar los ficheros, a unos de los seguientes [servicios ocultos de *Tor*](https://es.wikipedia.org/wiki/Tor_(red_de_anonimato)#Servicios_ocultos) que actuán de panel de control:

- `gx7ekbenv2riucmf[.]onion`
- `57g7spgrzlojinas[.]onion`
- `xxlvbrloxvriy2c5[.]onion`
- `76jdd2ir2embyv47[.]onion`
- `cwwnhwhlz52maqm7[.]onion`

Una vez pagado el rescate, supuestamente, los atacantes entregarían el archivo `00000000.dky`, que contiene la clave privada en claro necesaria para descifrar los ficheros secuestrados. El problema aquí radica en que **los pagos en *Bitcoins* son anónimos** por lo que no es directo saber quién ha realizado el pago y quién no.

Ya que no hay garantía de que esto ocurra y para no fomentar este tipo de actos delictivos, **la recomendación es nunca pagar un rescate**.

### Versiones de *WannaCry*
Hasta la fecha, se han identificado unas cuantas variantes del *malware* que se diferencian en su comportamiento como *worm* o como *ransomware*.

Podemos clasificar las versiones en alguna de estos tipos:

- En base al ***kill switch*** o dominio que use como interruptor de emergencia. En algunas versiones incluso ha sido eliminado.
- En base a la **cartera de _Bitcoins_** donde se reclame el pago.

Se cree que las versiones no han sido creadas por los autores originales sino que, más bien, se tratan de modificaciones realizadas por terceros.

## Prevención y mitigación
La vulnerabilidad utilizada por *WannaCry* está presente en todos los equipos con *Windows XP* a *Windows 10* que no hayan aplicado el parche de seguridad:

- [*MS17-10*](https://technet.microsoft.com/es-es/library/security/ms17-010.aspx) que se publicó el **14 de marzo de 2017** para los sistemas soportados oficialmente (*Windows Vista/2008/7/2012/8.1/10/2016*).
- [*KB4012598*](http://www.catalog.update.microsoft.com/search.aspx?q=kb4012598) que se publicó, de forma excepcional, el **13 de mayo de 2017** para los que ya no tienen soporte (*Windows XP/2003/8*).

En caso de no ser posible aplicar el parche de seguridad, se pueden adoptar medidas de mitigación como las que indica el [aviso de seguridad](https://www.certsi.es/alerta-temprana/avisos-seguridad/oleada-ransomware-afecta-multitud-equipos) que realizó el [CERT de Seguridad e Industria](https://www.certsi.es) de [INCIBE](https://www.incibe.es).

## Desinfección y recuperación
La **desinfección** se puede realizar con un antivirus actualizado ya que la mayoría de ellos detectan y desinfectan este *malware* desde poco después de su aparición. De todas formas, lo más recomendable es recuperar la última copia de seguridad que tengamos del equipo o realizar una instalación nueva en caso contrario.

La **recuperación**, sin embargo, no es tan sencilla ya que la clave privada que se usa en el proceso de cifrado de los ficheros es eliminada de la memoria y guardada cifrada en el archivo `00000000.eky`. La única posibilidad de obtenerla sería con la clave privada maestra que está en posesión de los creadores de *WannaCry*.

No obstante, existe una remota posibilidad de recuperar la clave privada de la memoria del sistema que es usar la herramienta [***Wanakiwi***](https://github.com/gentilkiwi/wanakiwi) pero sólo cuando se dan las siguientes circunstancias:

- El sistema operativo es *Windows XP* o *Windows 7*.
- No se ha reiniciado el equipo desde que se infectó.
- No ha pasado mucho tiempo desde el equipo se infectó o ha sido puesto en [*suspensión*](https://en.wikipedia.org/wiki/Sleep_mode) o [*hibernación*](https://en.wikipedia.org/wiki/Hibernation_(computing)) al poco de ser infectado.

## Conclusiones

En el [próximo artículo](/post/wannacry_impacto/) se abordarán los antecedentes de este ciberataque así como el impacto a nivel mundial que ha tenido.
