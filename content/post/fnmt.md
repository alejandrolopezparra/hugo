+++
title = "Certificados digitales de la FNMT-RCM"
draft = false
highlight = false
math = false
tags = ["DNIe","fnmt","certificado digital","seguridad","Firefox"]
date = "2017-05-06T12:00:00+02:00"

summary = """
Características de los certificados digitales de la Fábrica Nacional de Moneda y Timbre - Real Casa de la Moneda (*FNMT-RCM*) y su uso con *Firefox*.
"""

[header]
  image = "posts/FNMT.png"
  caption = ""

+++
Como continuación al [artículo dedicado al *DNIe*](/post/dnie/) y los certificados digitales que contiene, se tratarán los certificados digitales emitidos por la Entidad Pública de Certificación [*CERES* (*CERtificación ESpañola*)](http://www.cert.fnmt.es/) dependiente de la [Fábrica Nacional de Moneda y Timbre - Real Casa de la Moneda (*FNMT-RCM*)](http://www.fnmt.es/).

De la misma forma que ocurría con el *DNIe*, permiten acreditar la identidad de los intervinientes en las comunicaciones electrónicas y asegurar su procedencia e integridad. Por ende, también posibilitan la realización de **gestiones de forma segura a través de Internet** tanto con la Administración Pública como con las entidades privadas que los admitan.

En este artículo se describirán sus principales características, los servicios online donde se pueden usar y cómo obtenerlo, especialmente usando el navegador [*Firefox*](https://www.mozilla.org/es-ES/firefox/products/) de *Mozilla*.

## Características de los certificados de la *FNMT-RCM*
Según se explica en la [web de Prestador de Servicios de Certificación](http://www.cert.fnmt.es/certificados) de la *FNMT-RCM*, ésta emite diferentes tipos de certificados digitales o electrónicos en función del destinatario de los mismos: persona física, representante, Administración Pública y de componente.

### Certificado de Persona Física
Los [certificados de Persona Física, Ciudadano o Usuario](https://www.sede.fnmt.gob.es/certificados/persona-fisica) se emiten sin coste a cualquier ciudadano español o extranjero que esté en posesión de su *DNI* o *NIE* previa verificación de su identidad. Este certificado le permite identificarse de forma telemática, firmar y cifrar documentos electrónicos para realizar gestiones en [multitud de servicios online](https://www.cert.fnmt.es/certificados/donde-usar-certificado). Éstos son algunos ejemplos:

* Presentación y liquidación de impuestos.
* Presentación de recursos y reclamaciones.
* Cumplimentación de los datos del censo de población y viviendas.
* Consulta e inscripción en el padrón municipal.
* Consulta de multas de circulación.

Sería equivalente al *DNIe* pero se diferencian en algunos aspectos:

* Es un **único certificado** válido para la autenticación, cifrado y firma electrónica, al contrario de lo que ocurre en el *DNIe* que contiene 2 certificados distintos (`AUTENTICACIÓN` y `FIRMA`).
* Tiene una **vigencia de 48 meses** en lugar de los 30 meses que tienen los certificados digitales incluidos dentro del *DNIe*.
* Se puede realizar su **obtención telemáticamente**, sin tener que acudir a ninguna oficina, si se usa el *DNIe* o no han pasado más de 5 años desde la última vez que se acreditó la identidad.
* Es un **archivo descargable** y no tiene soporte físico.
* Se puede usar desde un navegador web, smartphone o tablet *Android* **sin necesidad de lector** de smart cards (tarjetas inteligentes).
* Permite que se use desde un cliente de correo para firmar y cifrar mensajes que enviemos o descifrar los mensajes que recibamos de forma confidencial.
* Requiere de medidas de seguridad adicionales para protegerse de un uso indebido. Entre otras sería recomendable:
  * Configurar el navegador y el correo electrónico para que solicite una contraseña cuando se quiera hacer uso del certificado.
  * Realizar una copia de seguridad del certificado digital por si se corrompe o se borra.

### Certificado de Representante
Los [certificados de Representante](https://www.sede.fnmt.gob.es/certificados/certificado-de-representante) se expiden [con coste](https://www.sede.fnmt.gob.es/certificados/certificado-de-representante/lista-de-precios) a personas físicas en calidad de representantes legales de [personas jurídicas](https://www.sede.fnmt.gob.es/certificados/certificado-de-representante/persona-juridica), [administradores únicos o solidarios](https://www.sede.fnmt.gob.es/certificados/certificado-de-representante/administrador-unico-solidario) y [entidades sin personalidad jurídica](https://www.sede.fnmt.gob.es/certificados/certificado-de-representante/entidad-sin-personalidad-juridica).

### Administración Pública
Los tipos de [certificados de Administración Pública](https://www.sede.fnmt.gob.es/certificados/administracion-publica) que se expiden a Administraciones Públicas son los siguientes:

* Certificado de firma electrónica del personal al servicio de la Administración Pública (Certificado de empleado público). 
* Certificado de Sede electrónica en el ámbito de la Administración.
* Certificado de Sello electrónico en el ámbito de la Administración.

### Certificados de Componente
Los [certificados de Componente](https://www.sede.fnmt.gob.es/certificados/certificado-componentes) se expiden [con coste](https://www.cert.fnmt.es/documents/10446703/10511896/Precios_Certificados_Ac_Componentes.pdf) para la identificación de servidores o aplicaciones informáticas:

* Certificado de [servidor web seguro *SSL/TLS*](https://www.cert.fnmt.es/catalogo-de-servicios/certificados-electronicos/certificado-servidor) (estándar, SAN multidominio, wildcard).
* Certificado para [firma de código](https://www.cert.fnmt.es/catalogo-de-servicios/certificados-electronicos/certificado-para-firma-de-codigo).
* Certificado de [sello de entidad](https://www.cert.fnmt.es/catalogo-de-servicios/certificados-electronicos/sello-entidad).
* Certificado de [sede y sello para la Administración Pública](https://www.sede.fnmt.gob.es/certificados/administracion-publica).

## Obtener un certificado de Persona Física
Para poder disponer de un certificado gratuito de persona física de la *FNMT-RCM*, también llamado de ciudadano o de usuario, es necesario realizar los siguientes 	[pasos explicados](https://www.sede.fnmt.gob.es/certificados/persona-fisica) en su web oficial: solicitud, acreditación de identidad y descarga.

### Solicitud o renovación del certificado
Antes de realizar la petición propiamente dicha, es necesario tener en cuenta una serie de [consideraciones previas](https://www.sede.fnmt.gob.es/certificados/persona-fisica/obtener-certificado-software/consideraciones-previas) que se encuentran detallados en la web de la sede electrónica de la *FNMT-RCM*:

* Los sistemas soportados son éstos:
  * El navegador [*Firefox*](https://www.mozilla.org/es-ES/firefox/products/) en un equipo con *Windows*, *GNU/Linux*, *macOS*, etc.
  * El navegador [*Internet Explorer*](https://support.microsoft.com/es-es/help/17621/internet-explorer-downloads) en un equipo con *Windows*.
  * La aplicación [Obtención certificado FNMT](https://play.google.com/store/apps/details?id=es.fnmt.android.certtool) de la *FNMT-RCM* en un smartphone o tablet con *Android*.
* Realizar todo el proceso con el mismo navegador/aplicación y usuario del sistema.
* No formatear ni actualizar el sistema ni el navegador/aplicación hasta que se complete el proceso.

Con esto en mente, es el momento de seguir las [instrucciones de configuración para *Firefox*](https://www.sede.fnmt.gob.es/preguntas-frecuentes/certificado-de-persona-fisica/-/asset_publisher/eIal9z2VE0Kb/content/1680-configuracion-necesaria-para-mozilla-firefox?inheritRedirect=false&redirect=https%3A%2F%2Fwww.sede.fnmt.gob.es%3A9440%2Fpreguntas-frecuentes%2Fcertificado-de-persona-fisica%3Fp_p_id%3D101_INSTANCE_eIal9z2VE0Kb%26p_p_lifecycle%3D0%26p_p_state%3Dnormal%26p_p_mode%3Dview%26p_p_col_id%3Dcolumn-2%26p_p_col_count%3D1), [*Internet Explorer*](https://www.sede.fnmt.gob.es/preguntas-frecuentes/certificado-de-persona-fisica/-/asset_publisher/eIal9z2VE0Kb/content/1628-configuracion-para-obtener-o-renovar-el-certificado-con-windows?inheritRedirect=false&redirect=https%3A%2F%2Fwww.sede.fnmt.gob.es%3A9440%2Fpreguntas-frecuentes%2Fcertificado-de-persona-fisica%3Fp_p_id%3D101_INSTANCE_eIal9z2VE0Kb%26p_p_lifecycle%3D0%26p_p_state%3Dnormal%26p_p_mode%3Dview%26p_p_col_id%3Dcolumn-2%26p_p_col_count%3D1) o [*Android*](https://www.sede.fnmt.gob.es/certificados/persona-fisica/obtener-certificado-con-android), dependiendo del sistema utilizado.

Una vez preparado el sistema, ya se podría realizar la [solicitud de un nuevo certificado con *DNIe*](https://www.sede.fnmt.gob.es/certificados/persona-fisica/obtener-certificado-con-dnie/solicitar-certificado) o la [solicitud sin *DNIE*](https://www.sede.fnmt.gob.es/certificados/persona-fisica/obtener-certificado-software/solicitar-certificado).

En el caso de la renovación de un certificado que aún no ha caducado, ésta se puede solicitar con hasta 60 días de antelación en la web de [renovación](https://www.sede.fnmt.gob.es/certificados/persona-fisica/renovar/solicitar-renovacion). 

#### Procedimiento con *Firefox*
En el caso de usar el navegador web *Firefox*, el proceso se resume en los siguientes pasos:

1. Verificar que están activadas las [cookies de terceros](https://support.mozilla.org/es/kb/configuracion-privacidad-historial-navegacion-funcion-no-quiero-ser-rastreado) en la configuración de *Firefox*.
2. Instalar el plug-in [*signTextJS Plus*](https://addons.mozilla.org/es/firefox/addon/signtextjs-plus/) en *Firefox*.
3. Importar[^unnecessary] en *Firefox* el [certificado de la Autoridad de Certificación raíz](https://www.sede.fnmt.gob.es/documents/10445900/10526749/AC_Raiz_FNMT-RCM_SHA256.cer) de la *FNMT-RCM*, marcando los siguientes usos:
  * Identificar páginas web.
  * Usuarios de correo electrónico.
  * Desarrolladores de aplicaciones.
[^unnecessary]: este paso no es necesario en las últimas versiones de Firefox porque ya viene instalada de serie
4. Realizar la solicitud de un [nuevo certificado con *DNIe*](https://www.sede.fnmt.gob.es/certificados/persona-fisica/obtener-certificado-con-dnie/solicitar-certificado), un [nuevo certificado sin *DNIe*](https://www.sede.fnmt.gob.es/certificados/persona-fisica/obtener-certificado-software/solicitar-certificado) o la [renovación de un certificado](https://www.sede.fnmt.gob.es/certificados/persona-fisica/renovar/solicitar-renovacion) que caducará en menos de 60 días.
  1. Cumplimentar el nombre, primer apellido y la dirección de correo electrónico, la cuál será usada para enviar al usuario un código de solicitud de 9 dígitos que posteriormente será necesario.
  2. Seleccionar la longitud de clave de 2048 bits (*Grado Alto* o *High Grade*).
  3. Aceptar las condiciones de expedición del certificado.
  4. Hacer clic en Enviar Petición.
5. Elegir ***token local*** de *Firefox* como el dispositivo usado para generar y almacenar la nueva clave (pública y privada) del certificado.

Si se ha usado el *DNIe* para realizar la solicitud de un nuevo certificado, será necesario firmarla con el certificado denominado *FIRMA* del *DNIe*. Esto permite acreditar la identidad del usuario sin necesidad de acudir a una oficina de registro.

De la misma forma, si se está realizando una renovación, será necesario firmarla con el certificado que se pretende renovar para autenticar la operación.

### Acreditación de identidad
En el caso de que no se haya usado el *DNIe* en la solicitud del certificado digital, será necesario acudir a una de las [oficinas de registro](http://mapaoficinascert.appspot.com/) para acreditar la identidad y continuar con la solicitud del certificado digital. Este paso tampoco será necesario si se está renovando el certificado y no han pasado más de 5 años desde la última vez que se acreditó la identidad.

Para ello, deberá presentar el *DNI* o pasaporte y, si es ciudadano extranjero, el *NIE*, junto con el código de solicitud que el usuario ha debido recibir en su correo electrónico.

### Descarga del certificado
Una vez acreditada la identidad, ya sea por haber usado el *DNIe* en la solicitud o por haber acudido a alguna oficina de registro, se puede usar el código recibido por correo electrónico, el primer apellido y el número de DNI para descargar el certificado digital de persona física desde la [web de descarga sin *DNIe*](https://www.sede.fnmt.gob.es/certificados/persona-fisica/obtener-certificado-software/descargar-certificado) o la [web de descarga con *DNIe*](https://www.sede.fnmt.gob.es/certificados/persona-fisica/obtener-certificado-con-dnie/descargar-certificado).

## Verificar los certificados digitales
La web de la *FNMT-RCM* también dispone de un servicio de verificación del estado y la validez de los certificados digitales que poseamos.

Para ello, se puede visitar la [web de verificación](https://www.sede.fnmt.gob.es/certificados/persona-fisica/verificar-estado) desde un navegador donde tengamos instalados los certificados a comprobar.

## Conclusiones
Los certificados digitales de la *FNMT-RCM* permiten realizar las mismas gestiones que los certificados que contiene el *DNIe* pero con un mayor alcance, ya que, además de para ciudadanos, también se emplean para Representantes legales, la Administración Pública y componentes como los servidores web *SSL/TLS*.

Su principal ventaja es la facilidad de uso así como la compatibilidad con distintos equipos y sistemas operativos. Además, si se dispone de un *DNIe*, es especialmente cómoda la obtención de un certificado de persona física ya que la acreditación de la identidad se puede comprobar sin tener que acudir físicamente a una oficina de registro.

Como contrapartida, requieren de la aplicación de ciertas medidas de seguridad ya que, per se, no son tan seguros como los del *DNIe*.
