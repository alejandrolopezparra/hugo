+++
title = "DNI electrónico y certificados digitales"
draft = false
highlight = false
math = false
tags = ["DNIe","certificados digitales","seguridad","macOS","Firefox"]
date = "2017-04-22T13:33:10+02:00"

summary = """
Características del Documento Nacional de Identidad electrónico español (*DNIe*) y su uso en el sistema operativo *macOS*.
"""

[header]
  image = "posts/DNIe.png"
  caption = ""

+++
El [Documento Nacional de Identidad electrónico español (*DNIe*)](https://www.dnielectronico.es) es emitido por la Dirección General de la Policía (*DGP*) y responde a la necesidad de otorgar identidad personal a los ciudadanos españoles para su uso en la [Sociedad de la Información](https://es.wikipedia.org/wiki/Sociedad_de_la_informaci%C3%B3n). Permite acreditar la identidad de los intervinientes en las comunicaciones electrónicas así como asegurar su procedencia e integridad. De este modo, es posible realizar **gestiones de forma segura a través de Internet** tanto con la Administración Pública como con las entidades privadas que lo adopten. 

En este artículo se describirán sus principales características y algunos servicios online donde se puede usar. También se indicarán los pasos para hacerlo funcionar correctamente en el sistema operativo [*macOS*](https://es.wikipedia.org/wiki/MacOS) de Apple.

## 1. Características del *DNIe*
### 1.1. Fundamentos básicos
El *DNIe* se basa en principios matemáticos de criptografía aplicados a los sistemas de información para que éstos se puedan usar de forma segura. [Infraestructura de clave pública (PKI)](https://es.wikipedia.org/wiki/Infraestructura_de_clave_p%C3%BAblica), [certificados digitales](https://es.wikipedia.org/wiki/Certificado_digital) y [criptografía de clave pública o asimétrica](https://es.wikipedia.org/wiki/Criptograf%C3%ADa_asim%C3%A9trica) son los principales. Éstos permiten garantizar características básicas de la seguridad de la información: [Autenticación](https://es.wikipedia.org/wiki/Seguridad_de_la_informaci%C3%B3n#Autenticaci.C3.B3n_o_autentificaci.C3.B3n), [Confidencialidad](https://es.wikipedia.org/wiki/Seguridad_de_la_informaci%C3%B3n#Confidencialidad), [Disponibilidad](https://es.wikipedia.org/wiki/Seguridad_de_la_informaci%C3%B3n#Disponibilidad), [Integridad](https://es.wikipedia.org/wiki/Seguridad_de_la_informaci%C3%B3n#Integridad) y [No repudio](https://es.wikipedia.org/wiki/Seguridad_de_la_informaci%C3%B3n#No_repudio_o_irrefutabilidad).

De forma resumida, podríamos [describir el *DNIe*](https://www.dnielectronico.es/PortalDNIe/PRF1_Cons02.action?pag=REF_103) como una [tarjeta inteligente o smart card](https://es.wikipedia.org/wiki/Tarjeta_inteligente) que incorpora un chip criptográfico capaz de almacenar de forma segura la misma información que se encuentra impresa, las imágenes digitalizadas de la fotografía, firma manuscrita e impresiones dactilares. De la misma forma, contiene 2 certificados digitales denominados *AUTENTICACIÓN* y *FIRMA* con sus correspondientes claves privadas que están protegidas por una clave personal de acceso (*PIN*) alfanumérica. Es importante notar que, aunque el *DNIe* tiene una vigencia de 10 años desde el momento de su expedición, los certificados digitales almacenados internamente **caducan a los 30 meses** y, por tanto, **deben ser renovados en una comisaría de policía** para que sigan siendo válidos.

El chip criptográfico posibilita las siguientes funciones cuando sus certificados digitales están en vigor y se conoce el *PIN*:

* Acreditar electrónicamente y de forma inequívoca la identidad de la persona. Es una **Autenticación** de doble factor, algo que se tiene (el certificado digital *AUTENTICACIÓN* que va dentro del *DNIe*) y algo que se conoce (el *PIN*).
* Firmar digitalmente documentos electrónicos, otorgándoles validez jurídica. Se usa el *PIN* y el certificado digital *FIRMA* para proporcionar **Integridad** y **No repudio**.

Se pueden encontrar más detalles técnicos revisando las características [electrónicas](https://www.dnielectronico.es/PortalDNIe/PRF1_Cons02.action?pag=REF_083) y [físicas](https://www.dnielectronico.es/PortalDNIe/PRF1_Cons02.action?pag=REF_084) del *DNIe*.

### 1.3. Versiones
Existen 2 variantes distintas del *DNIe*.

* La [primera](https://www.dnielectronico.es/PortalDNIe/PRF1_Cons02.action?pag=REF_106) apareció por primera vez en el año 2006 y dejó de expedirse en 2015.
{{< figure src="https://www.dnielectronico.es/img/dnie_descrip.jpg" title="DNIe" >}}

* Desde 2016 se empezó a emitir el denominado [*DNI 3.0*](https://www.dnielectronico.es/PortalDNIe/PRF1_Cons02.action?pag=REF_103).
{{< figure src="https://www.dnielectronico.es/img/DNI_PERSPECTIVA_3.jpg" title="DNI 3.0" >}}

Ambas versiones son válidas a día de hoy pero tienen [algunas diferencias](https://www.dnielectronico.es/PortalDNIe/PRF1_Cons02.action?pag=REF_038). La principales ventajas del *DNI 3.0* son las siguientes:

* Dispone de **mejores medidas de seguridad físicas** que dificultan aún más su falsificación.
* Permite el **uso desde smartphones y tablets** a través de la tecnología de comunicación inalámbrica de corto alcance y alta frecuencia [*NFC*](https://es.wikipedia.org/wiki/Near_field_communication). Como medida de protección adicional, incorpora un número de autenticación de tarjeta (*Card Authentication Number* o *CAN*).
* Presenta una estructura de datos **equivalente al pasaporte** que posibilita usarlo como Documento de Viaje en los países que disponen de Pasos Rápidos de Frontera (*ABC Systems*).

### 1.2. Requisitos
Para poder hacer uso del *DNIe* es necesario cumplir algunos requisitos físicos (*hardware*) y lógicos (*software*):

* Se debe tener alguno de los siguientes elementos *hardware*:
 * **Lector con contacto**: un lector de tarjetas inteligentes que cumpla el estándar *ISO-7816 (1/2/3)* y sea compatible con *API PC/SC* (*Personal Computer/Smart Card*), *CSP* (*Cryptographic Service Provider* de *Microsoft*), *API PKCS#11*.
 * **Lector sin contacto**: un dispositivo *NFC* cumpla el estándar *ISO 14443*, tipo A o B. La mayoría de los *smartphones* y *tablets* lo son.

{{< figure src="https://www.dnielectronico.es/img/LECTORES%20PARA%20DNI_FINAL.jpg" title="Lectores DNIe" >}}

* Elementos software necesarios:
 * En el caso de usar **lectores con contacto**:
     * Sistema operativo (*Windows*, *GNU/Linux*, *macOS*).
     * Navegador (*Internet Explorer*, *Chrome*, *Firefox*) con los [certificados raíz de la *DGP*](https://www.dnielectronico.es/PortalDNIe/PRF1_Cons02.action?pag=REF_076).
     * Controlador (driver) para el lector. Suele venir junto con el sistema operativo aunque algunos lectores necesitan uno específico creado por el fabricante.
     * Controlador (driver) criptográfico específico para el *DNIe*: [*Smart Card Mini-Driver*](https://www.dnielectronico.es/PortalDNIe/PRF1_Cons02.action?pag=REF_1101) en *Windows* o [*PKCS#11*](https://www.dnielectronico.es/PortalDNIe/PRF1_Cons02.action?pag=REF_1110) en otros sistemas operativos como *GNU/Linux* o *macOS*.
 * En el caso de usar **lectores sin contacto**:
     * Sistema operativo (*Android*, *iOS*).
     * Aplicación compatible con *DNI 3.0*.

## 2. Usos del *DNIe*
Como se comentaba al principio del artículo, el *DNIe* posibilita realizar **gestiones de forma segura a través de Internet** tanto con la Administración Pública como con algunas entidades privadas que lo han adoptado.

En la [web del dnielectronico](https://www.dnielectronico.es) se recoge un listado exhaustivo de servicios disponibles de la [Administración General del Estado](https://www.dnielectronico.es/PortalDNIe/PRF1_Cons02.action?pag=REF_510), [Comunidades Autónomas](https://www.dnielectronico.es/PortalDNIe/PRF1_Cons02.action?pag=REF_520), [Administración Local](https://www.dnielectronico.es/PortalDNIe/PRF1_Cons02.action?pag=REF_530), [otros organismos públicos](https://www.dnielectronico.es/PortalDNIe/PRF1_Cons02.action?pag=REF_540) y el [sector privado](https://www.dnielectronico.es/PortalDNIe/PRF1_Cons02.action?pag=REF_550).

De todos ellos, algunos de los más importantes son los siguientes:

* Servicios electrónicos de la [Administración General Estado](https://sede.administracion.gob.es/PAG_Sede/ServiciosElectronicos/ServiciosElectronicosAGE.html).
* Sede electrónica de la [Seguridad Social](https://sede.seg-social.gob.es/).
* Sede electrónica de la [Agencia Tributaria](https://www.agenciatributaria.gob.es/AEAT.sede/Inicio/Inicio.shtml).

## 3. El *DNIe* en *macOS*
Además de disponer de un lector compatible, se necesitan completar algunos pasos para que el *DNIe* sea reconocido y funcione correctamente en *macOS*. Lo más recomendable es seguir las instrucciones que se describen en el [manual de instalación](https://www.dnielectronico.es/PDFs/manuales_instalacion_unix/Manual_de_Instalacion_de_MulticardPKCS11_DNIE_V1.pdf) publicado por la *DGP*.

### 3.1. Instalar *Firefox*
A día de hoy, el único navegador soportado por el *DNIe* en *macOS* es *Mozilla Firefox* por lo que tendremos que descargar la versión de Escritorio desde su [web oficial](https://www.mozilla.org/es-ES/firefox/desktop/) e instalarlo.

### 3.2. Driver *PCKS#11*
A continuación debemos instalar el driver *PKCS#11* compatible con el *DNIe* que se puede descargar desde el [área de descargas](https://www.dnielectronico.es/PortalDNIe/PRF1_Cons02.action?pag=REF_1113) de la web del dnielectronico.

Una vez instalado el driver, se debe configurar *Firefox* para que pueda usar el *DNIe* con un lector:

* Ir a *Firefox > Preferencias > Avanzado > Cifrado > Dispositivos de seguridad*.
* Seleccionar *Cargar*.
* Asignar un nombre al módulo, por ejemplo, *DNIe*.
* Indicar la ruta hacia el driver, ```/Library/Libpkcs11-dnie/lib/libpkcs11-dnie.so```
* Hacer clic en *Aceptar*.

### 3.3. Instalar los certificados de la policía
Para que *Firefox* no dé errores de verificación es necesario instalar los [certificados de las Autoridades de Certificación raíz](https://www.dnielectronico.es/PortalDNIe/PRF1_Cons02.action?pag=REF_077) de la *DGP* y aprobar cada uno de ellos para los siguientes usos:

* Identificar páginas web.
* Usuarios de correo electrónico.
* Desarrolladores de aplicaciones.

Aunque no es estrictamente necesario, sí que es recomendable repetir el paso anterior con los [certificados de las Autoridades de Certificación subordinadas](https://www.dnielectronico.es/PortalDNIe/PRF1_Cons02.action?pag=REF_078) de la *DGP*.

### 3.4. Verificar que funciona
Una vez completados todos los pasos de instalación y preparación del sistema para el uso del *DNIe*, es el momento de comprobar que funciona correctamente. Para ello debemos utilizar un servicio denominado *Autoridad de Validación* y, según se indica en la [sección de validación](https://www.dnielectronico.es/PortalDNIe/PRF1_Cons02.action?pag=REF_320) de la web del dnielectronico, hay 2 prestadores de servicio de validación para el *DNIe*:

* [Fábrica Nacional de Moneda y Timbre - Real Casa de la Moneda (FNMT-RCM)](https://www.sede.fnmt.gob.es/certificados/persona-fisica/verificar-estado).
* [@FIRMA](https://valide.redsara.es/valide/).

Estos servicios nos permitirán, además, conocer el estado de los certificados que van dentro del *DNIe*:

* **Válido**: el certificado digital no ha sido revocado ni ha expirado.
* **Revocado**: el certificado digital ha sido invalidado por la *DGP*. Esto suele ocurrir al generar un nuevo *DNIe* o renovar sus certificados digitales.
* **Expirado**: se ha superado la fecha en la que caduca el certificado digital y debería renovarse en una comisaría de policía.

## 4. Conclusiones
En los últimos años, a través de la [Agenda Digital para España](http://www.agendadigital.gob.es), el gobierno español está impulsando distintos planes en materia de Tecnologías de la Información y las Comunicaciones (TIC) y de Administración Electrónica para el cumplimiento de los objetivos de la Agenda Digital para Europa e incorpora objetivos específicos para el desarrollo de la economía y la sociedad digital en España.

El *DNIe* forma parte de estos planes ya que es una herramienta que permite a los ciudadanos españoles su **identificación digital o electrónica segura** frente a la administración pública y las empresas privadas, posibilitando el acceso a los servicios de la [Sociedad de la Información](https://es.wikipedia.org/wiki/Sociedad_de_la_informaci%C3%B3n).

Aunque su uso no es todo lo sencillo que debería especialmente en equipos que no disponen de *Windows*, una vez que se consigue que funcione correctamente, permite realizar multitud de gestiones electrónicas tanto con la Administración Pública como con el sector privado, sobre todo bancos y entidades financieras.