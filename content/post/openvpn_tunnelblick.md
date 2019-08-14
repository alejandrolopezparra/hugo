+++
title = "Servidor de VPN en macOS"
draft = true
highlight = true
math = false
tags = ["VPN","OpenVPN","macOS","seguridad"]
date = "2019-08-12T12:00:00+02:00"
summary = """
Guía para instalar y configurar un servidor *OpenVPN* en *macOS* con *Tunnelblick*.
"""

[header]
  image = "posts/OpenVPN-Tunnelblick.png"
  caption = ""

+++

Uno de los servicios de red más importantes para la seguridad de las comunicaciones es, sin duda, [Virtual Private Network (*VPN*)](https://en.wikipedia.org/wiki/Virtual_private_network). Esta tecnología permite crear un **túnel entre 2 redes privadas remotas**, alejadas entre sí, **para que se comuniquen de forma segura**, como si estuvierán directamente conectadas, pero a través de un canal inseguro como es *Internet*. Al igual que la mayoría de los servicios de red, *VPN* se basa en un modelo cliente-servidor, en el que el cliente es el que inicia la solicitud de establecimiento del túnel, mientras que el servidor está permanentemente esperando a recibir conexiones de los clientes.

Sin extendernos demasiado, podríamos decir que existen, atendiendo a la topología de la conexión, 2 tipos de *VPN*:

- ***Host-to-Site***: también conocida como *host-to-network*, *road warrior* o *remote access*, en el que hay 1 servidor, que debe ser accesible desde *Internet*, que permite a varios clientes conectar a su red privada a través del túnel. 
- ***Site-to-Site***: también conocida como *network-to-network* en el que cualquiera de los extremos actúa como cliente y servidor a la misma vez, permitiendo al otro acceder a su red privada. En este modelo, ambos extremos deben ser accesibles desde *Internet* para que el otro pueda realizar la conexión y se establezca el túnel.


Existen muchos casos de usos para las *VPN*, pero algunos de los más habituales son los siguientes:

- **Interconexión de sedes u oficinas**: mediate *VPN Site-to-Site*. Habitual en los entornos corporativos, ya que posibilita que 2 sedes remotas, incluso en distintos países, se conecten entre sí como si estuvieran en el mismo edificio.
- **Acceso remoto de trabajadores a sus oficinas**: mediante *VPN Host-to-Site*. Común en los entornos corporativos, ya que permite que los empleados se conecten, desde cualquier lugar, a su oficina y trabajen como si estuvieran físicamente allí.
- **Mantener la privacidad y evitar la [censura en Internet](https://en.wikipedia.org/wiki/Internet_censorship)**: mediante *VPN Host-to-Site*. Más propio de los entornos domésticos, sobretodo en países donde el gobierno "espía" a sus ciudadanos o restringe ciertos contenidos por considerarlos inadecuados. Existen servicios de *VPN* que permiten navegar por *Internet* de forma segura, sin que el proveedor de acceso a *Internet* (*ISP*) pueda saber a qué páginas o servicios accedemos y, por tanto, tampoco pueda bloquearlos.
- **Saltar la restricción geográfica o [geobloqueo](https://en.wikipedia.org/wiki/Geo-blocking)**: mediante *VPN Host-to-Site*. Más propio de los entornos domésticos que quieren acceder a contenidos que son exclusivos para ciertos países, especialmente realizado por los proveedores de contenido audiovisual (*HBO*, *Netflix*, *YouTube*, etc.). Existen servicios de *VPN* que permiten navegar por *Internet* eligiendo el país desde el que queremos que parezca estar originada la conexión.

Hay multitud de tecnologías con las que implementar *VPN*: [*IPSec*](https://en.wikipedia.org/wiki/Internet_Protocol_Security), [*PPTP*](https://en.wikipedia.org/wiki/Point-to-Point_Tunneling_Protocol), [*L2TP*](https://en.wikipedia.org/wiki/Layer_2_Tunneling_Protocol), [*SSL/TLS*](https://en.wikipedia.org/wiki/Transport_Layer_Security), etc. Cada una tiene sus ventajas e inconvenientes, pero nos vamos a centrar en una de las más utilizadas, [*OpenVPN*](https://community.openvpn.net/openvpn), que es de código libre y que está soportada por los protocolos criptográficos *SSL/TLS*.

A continuación, se detallan los pasos a seguir para implementar una *VPN* de tipo *Host-to-Site* con *OpenVPN*, con el objetivo de que darnos acceso remoto a nuestra red privada de casa e, incluso, navegar por *Internet* como si estuviéramos allí.

En este primer post nos centraremos en instalar y configurar el servidor, con autenticación basada en certificados digitales. Para ello, haremos uso de la aplicación de código libre [*Tunnelblick*](https://tunnelblick.net/), que básicamente es una interfaz gráfica de usuario que facilita el control de *OpenVPN* en *macOS*.

En el siguiente post veremos el proceso de instalación y configuración del cliente en *Android*, mediante la aplicación [*OpenVPN for Android*](http://ics-openvpn.blinkt.de/)).

## Servidor de *OpenVPN*
Basándonos en la documentación oficial [Using Tunnelblick as a VPN Server](https://tunnelblick.net/cServer.html) y en las instrucciones de [macOS OpenVPN Server and Client Configuration (OpenVPN, Tunnelblick, PF)](https://github.com/essandess/macos-openvpn-server), vamos a preparar el servidor siguiendo estos pasos:

1. Instalar *Tunnelblick*.
2. Generar la configuración de *OpenVPN*.
3. Añadir la configuración a *Tunnelblick*.
4. Realizar ajustes finales.

### 1. Instalar *Tunnelblick*
*Tunnelblick* es una aplicación para *macOS* que incluye *OpenVPN* y que permite gestionarlo para que funcione tanto en modo cliente como en modo servidor. En nuestro caso, nos interesa la funcionalidad de servidor.

Para empezar, debemos descargar la [última versión estable](https://tunnelblick.net/release/Latest_Tunnelblick_Stable.dmg) desde la página web del proyecto e instalarla. Una vez instalada, la ejecutamos y debería aparecernos el mensaje de bienvenida de *Tunnelblick*:
{{< figure src="/img/posts/OpenVPN-Tunnelblick-Welcome.png" title="" >}}

Seleccionamos la opción por defecto "**I have configuration files**" y nos aparecerá un mensaje que nos indica cómo podremos posteriormente añadir el fichero de configuración. 

### 2. Generar la configuración de *OpenVPN*
En este punto, creamos un directorio, por ejemplo `~/server`, donde incluiremos todos los ficheros de configuración necesarios por *OpenVPN*. 

Empezaremos por crear dentro el fichero `~/server/server.ovpn`, que deberá contener la configuración del sevidor de *OpenVPN*. Se puede usar el siguiente ejemplo:

```bash
# Which TCP/UDP port should OpenVPN listen on?
# If you want to run multiple OpenVPN instances
# on the same machine, use a different port
# number for each one.  You will need to
# open up this port on your firewall.
port 1194

# TCP or UDP server?
proto udp

# "dev tun" will create a routed IP tunnel,
# "dev tap" will create an ethernet tunnel.
# Use "dev tap0" if you are ethernet bridging
# and have precreated a tap0 virtual interface
# and bridged it with your ethernet interface.
# If you want to control access policies
# over the VPN, you must create firewall
# rules for the the TUN/TAP interface.
# On non-Windows systems, you can give
# an explicit unit number, such as tun0.
# On Windows, use "dev-node" for this.
# On most systems, the VPN will not function
# unless you partially or fully disable
# the firewall for the TUN/TAP interface.
dev tun

# SSL/TLS root certificate (ca), certificate
# (cert), and private key (key).  Each client
# and the server must have their own cert and
# key file.  The server and all clients will
# use the same ca file.
#
# See the "easy-rsa" directory for a series
# of scripts for generating RSA certificates
# and private keys.  Remember to use
# a unique Common Name for the server
# and each of the client certificates.
#
# Any X509 key management system can be used.
# OpenVPN can also use a PKCS #12 formatted key file
# (see "pkcs12" directive in man page).
ca ca.crt
cert server.crt
key server.key  # This file should be kept secret

# Diffie hellman parameters.
# Generate your own with:
#   openssl dhparam -out dh2048.pem 2048
dh dh2048.pem

# Network topology
# Should be subnet (addressing via IP)
# unless Windows clients v2.0.9 and lower have to
# be supported (then net30, i.e. a /30 per client)
# Defaults to net30 (not recommended)
topology subnet

# Configure server mode and supply a VPN subnet
# for OpenVPN to draw client addresses from.
# The server will take 10.8.0.1 for itself,
# the rest will be made available to clients.
# Each client will be able to reach the server
# on 10.8.0.1. Comment this line out if you are
# ethernet bridging. See the man page for more info.
server 10.8.0.1 255.255.255.0

# Maintain a record of client <-> virtual IP address
# associations in this file.  If OpenVPN goes down or
# is restarted, reconnecting clients can be assigned
# the same virtual IP address from the pool that was
# previously assigned.
ifconfig-pool-persist /Library/Application\ Support/Tunnelblick/server-ipp.txt

# If enabled, this directive will configure
# all clients to redirect their default
# network gateway through the VPN, causing
# all IP traffic such as web browsing and
# and DNS lookups to go through the VPN
# (The OpenVPN server machine may need to NAT
# or bridge the TUN/TAP interface to the internet
# in order for this to work properly).
push "redirect-gateway def1 bypass-dhcp bypass-dns"

# The keepalive directive causes ping-like
# messages to be sent back and forth over
# the link so that each side knows when
# the other side has gone down.
# Ping every 10 seconds, assume that remote
# peer is down if no ping received during
# a 120 second time period.
keepalive 10 120

# Select a cryptographic cipher.
# This config item must be copied to
# the client config file as well.
# Note that v2.4 client/server will automatically
# negotiate AES-256-GCM in TLS mode.
# See also the ncp-cipher option in the manpage
cipher AES-256-CBC

# The maximum number of concurrently connected
# clients we want to allow.
max-clients 10

# It's a good idea to reduce the OpenVPN
# daemon's privileges after initialization.
#
# You can uncomment this out on
# non-Windows systems.
user nobody
group nobody

# The persist options will try to avoid
# accessing certain resources on restart
# that may no longer be accessible because
# of the privilege downgrade.
persist-key
persist-tun

# Set the appropriate level of log
# file verbosity.
#
# 0 is silent, except for fatal errors
# 4 is reasonable for general usage
# 5 and 6 can help to debug connection problems
# 9 is extremely verbose
verb 3
```

Seguidamente, emplearemos la suite de utilidades criptográficas [*EasyRSA*](https://github.com/OpenVPN/easy-rsa), que incorpora *Tunnelblick* para facilitar la generación de la [*Public Key Infraestructure (PKI)*](https://en.wikipedia.org/wiki/Public_key_infrastructure) y el resto de ficheros que necesita *OpenVPN* para realizar la autenticación basada en certificados digitales. En la línea de comandos ejecutaremos lo siguiente:

```bash
cd ~/Library/Application\ Support/Tunnelblick/easy-rsa
# inicializar las variables de entorno
. vars
# limpiar el entorno
./clean-all
# crea el certificado raíz de la Certification Authority (CA)
./build-ca
# generar el certificado del servidor firmado por la CA
./build-key-server
# crear los parámetros Diffie-Hellman del servidor
./build-dh
```

Posteriormente, copiamos los ficheros que necesita *OpenVPN* y que hemos creado en el paso anterior:

```bash
cd keys
cp ca.crt server.key server.crt dh2048.pem ~/server/
```

NOTA: los nombres de los ficheros server.key y server.crt pueden ser diferente, dependiendo de las respuestas dadas a `build-key-server`.

### 3. Añadir la configuración a *Tunnelblick*
Una vez tenemos en el directorio `~/server/` todos los ficheros necesarios, hacemos clic izquierdo sobre el icono de *Tunnelblick* en la barra de menús de estado ([status menu bar](https://support.apple.com/guide/mac-help/the-menu-bar-mchlp1446/mac)) y seleccionamos *VPN Details*.
{{< figure src="/img/posts/OpenVPN-Tunnelblick-VPNdetails.png" title="" >}}

A continuación, arrastramos el fichero `server.ovpn` a la ventana de *Tunnelblick*.
{{< figure src="/img/posts/OpenVPN-Tunnelblick-Add.png" title="" >}}

Es posible que nos aparezca un aviso como el de la siguiente imagen, en cuyo caso, debemos seleccionar la opción "**Always use the plugin**". De lo contrario, el servidor no podrá restablecer túneles cuando éstos se desconecten, ya que la configuración que hemos elegido reduce, como medida de seguridad adicional, los privilegios del servidor después de la inicialización.
{{< figure src="/img/posts/OpenVPN-Tunnelblick-Down.png" title="" >}}

En este punto, ya podríamos iniciar (***Connect***) o parar (***Disconnect***) el servidor a nuestro antojo. No obstante, si lo que pretendemos es que el servicio se inicie automáticamente al enceder el equipo, debemos seleccionar las opciones que se ven en la siguiente imagen, asegurándonos antes que está desconectado:

1. ***Make Configuration Shared***
2. ***Connect: When computer starts***
3. ***Set DNS/WINS: Do not set nameserver***

{{< figure src="/img/posts/OpenVPN-Tunnelblick-Shared.png" title="" >}}

En mi experiencia, después de reiniciar por primera vez el equipo, puede que haya que repetir este último paso para conseguir que *Tunnelblick* deje todo perfectamente configurado.


### 4. Realizar ajustes finales
A estas alturas, ya deberíamos tener correctamente configurado nuestro servidor *OpenVPN*, el cual estaría preparado para recibir conexiones de los clientes. No obstante, seguramente queramos llevar a cabo algunas automatizaciones y ajustes para que todo funcione como sería deseable.

#### Configurar router
Empezamos por **permitir que los clientes puedan conectar desde _Internet_** a nuestro servidor *OpenVPN*. Para ello, podemos abrir en nuestro router el puerto por defecto asignado a [*OpenVPN* (*1194/UDP*)](https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xhtml?search=1194), u otro que nos guste más, y redirigirlo al puerto *1194/UDP* de la dirección *IP* privada que tenga asignado nuestro equipo.

Otra opción viable sería configurar un *Virtual Exposed Host* o [*DMZ*](https://en.wikipedia.org/wiki/DMZ_(computing)) en nuestro router, que apunte a la dirección *IP* privada del equipo, de forma que todo el tráfico recibido por el router sería reenviado al equipo.

Sea cual sea la que decidamos, es muy recomendable que la asignación de la dirección *IP* de nuestro servidor sea manual o que la hayamos fijado en nuestro servidor [*DHCP*](https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol).

#### Configurar *DDNS*
Otro de los puntos recomendables, especialmente si nuestro proveedor de acceso a *Internet* ([*ISP*](https://en.wikipedia.org/wiki/Internet_service_provider)) nos asigna la dirección *IP* pública dinámicamente, es **registrar un nombre [_Dynamic DNS (DDNS)_](https://en.wikipedia.org/wiki/Dynamic_DNS)**. De esta forma, podremos acceder a nuestro servicio *OpenVPN* independientemente de la dirección *IP* pública que tenga en cada momento, ya que lo haremos por nombre. Existen varios proveedores de *DDNS* y algunos de ellos son gratuitos, como es el caso de [*No-IP*](https://www.noip.com/free).

Para el correcto funcionamiento de este servicio es necesario indicarle periódicamente la dirección *IP* pública que tiene asignado nuestro router. Si tenemos la suerte de que nuestro router tenga soporte para esta funcionalidad, sería tan sencillo como configurar allí cuál es nuestro proveedor (*No-IP*, *DynDNS*, etc.), nombre DDNS registrado, usuario y contraseña de nuestra cuenta. En este caso, el router se encargará automáticamente de actualizar la dirección *IP* pública cada vez que ésta cambie.

Si nuestro router no es de los afortunados, para *No-IP* también lo podemos conseguir a través del [agente de actualización *DDNS* para *macOS*](https://www.noip.com/download?page=mac), que tendrá que ejecutarse en nuestro servidor. Éste tiene el inconveniente de que corre en espacio de usuario, es decir, se inicia después de que el usuario haya hecho *login*, pero no antes, ni tampoco después del *logout*. Otra posibilidad es compilar el [agente de actualización para *Linux*](https://www.noip.com/download?page=linux) en *macOS* y ejecutarlo como demonio en el arraque del servidor o después de que se inicie el servicio *OpenVPN*.

En mi caso, opté por hacer algunas modificaciones al código fuente del agente para *Linux*, que consisten en ajustarlo a la arquitectura *macOS* y sustituir el uso de *HTTP* por *HTTPS*. El proceso se podría repetir de la siguiente manera:

```bash
# descargar el código fuente del agente para Linux
curl -O https://www.noip.com/client/linux/noip-duc-linux.tar.gz
# descomprimir el archivo
tar xzf noip-duc-linux.tar.gz
# descargar el parche con mis cambios al código fuente
curl -O https://www.alejandrolopezparra.es/noip-2.1.9-1.patch
# aplicar el parche al código fuente original
patch -p0 -i noip-2.1.9-1.patch
# compilar el programa
cd noip-2.1.9-1/
make clean
make
# instalarlo en /usr/local/ y ejecutar el asistente de configuración
make install
# ajustar los permisos para poder ejecutarlo sin privilegios
chown :nobody /usr/local/etc/no-ip2.conf
chmod g+w /usr/local/etc/no-ip2.conf
```

Para lanzarlo como demonio, tan sólo tendríamos que ejecutar el comando `/usr/local/bin/noip2`. Si queremos que éste se inicie automáticamente cada vez que arranque el sistema, podemos optar por añadir un script a la configuración del servidor de *OpenVPN* para que se ejecute al iniciar el servidor. Esto se explica al final de este post.

#### Configurar *Packet forwarding*
En el caso de que queramos que, además de al servidor *OpenVPN*, los clientes remotos puedan acceder al resto de equipos de nuestra red privada, o incluso a *Internet*, será necesario **habilitar [_Packet forwarding_](https://en.wikipedia.org/wiki/Packet_forwarding) en nuestro servidor**.

En *macOS*, esto se configue de forma temporal con el comando `sysctl -w net.inet.ip.forwarding=1`, pero, si queremos que el cambio sea resistente a reinicios, debemos crear el fichero `/etc/sysctl.conf` con el siguiente contenido:

```bash
# IP forwarding for OpenVPN
net.inet.ip.forwarding=1
```

#### Configurar routing o *NAT*
Adicionalmente, tendremos que optar por configurar adecuadamente las rutas en el router y en todos los equipos de la red, o habilitar [*Network address translation* o *NAT*](https://en.wikipedia.org/wiki/Network_address_translation).

Mi preferencia ha sido la de usar *NAT* porque es más fácil de implementar y mantener, ya que se instruye al servidor para que traduzca las direcciones *IP* de los clientes por la suya propia, aunque también se podría usar una dirección *IP* del mismo rango que se reserve para este fin. 

*macOS*, desde su versión *OS X 10.7 Lion*, incorpora de serie un [*stateful firewall*](https://en.wikipedia.org/wiki/Stateful_firewall), heredado del sistema operativo [*OpenBSD*](https://en.wikipedia.org/wiki/OpenBSD), denominado [*Packet Filter* o *PF*](https://en.wikipedia.org/wiki/PF_(firewall)). Se trata de un firewall de inspección de estado muy potente que permite filtrado de paquetes y *NAT*, al estilo de [*iptables*](https://en.wikipedia.org/wiki/Iptables), pero con diferencias importantes. Me he tenido que apoyar en varias referencias para intentar entender cómo funciona *PF*, sus especifidades en *macOS* y cómo se relaciona con [*Application Firewall* o *socketfilterfw*](https://support.apple.com/en-us/HT201642), otro firewall que también integra *macOS* desde *OS X 10.5.1 Leopard*:

- [Murus. OS X PF Manual](https://murusfirewall.com/Documentation/OS%20X%20PF%20Manual.pdf)
- [How can I setup my mac (OS X Yosemite) as an internet gateway](https://apple.stackexchange.com/questions/192089/how-can-i-setup-my-mac-os-x-yosemite-as-an-internet-gateway)
- [Wasya Wiki. Pf](https://wiki.wasya.co/index.php/Pf)
- [Quickly and easily adding pf (packet filter) firewall rules on macOS (OSX)](https://blog.neilsabol.site/post/quickly-easily-adding-pf-packet-filter-firewall-rules-macos-osx/)
- [Protect Your Mac with PF, the All Powerful Firewall](https://robert-chalmers.uk/2018/10/03/protect-your-mac-with-pf-the-all-powerful-firewall/)
- [tracphil. pfctl cheat sheet](https://gist.github.com/tracphil/4353170)
- [pfctl - howto add an anchor and make it active / load it](https://apple.stackexchange.com/questions/312400/pfctl-howto-add-an-anchor-and-make-it-active-load-it)

A modo de resumen, algunos detalles importantes de *PF* en *macOS* son los siguientes:

- Activación
 - Se carga en el arranque del sistema con la configuración por defecto, pero desactivado.
 - Si una aplicación o servicio lo necesita, puede activarlo con `pfctl -E` y recibe un *token*. 
 - Si una aplicación o servicio deja de necesitarlo, puede liberarlo con `pfctl -X <token>`.
 - Si todas las aplicaciones han liberado su *token*, el firewall se desactiva.
- Configuración
 - El fichero de configuración base es `/etc/pf.conf`, aunque éste referencia a otros ficheros.
 - Hay que seguir un orden estricto en la definición de reglas: Options, Normalization (*scrub*), Queueing, Translation (*rdr* y *nat*), Packet filtering (*block* y *pass*).
- Anchors
 - Conjunto de reglas que comparten nombre.
 - Un *anchor* puede referenciar a otro *anchor*, generando así una estructura anidada.
 - Se pueden modificar las reglas de forma dinámica dentro un *anchor*.
 - Los *anchors* raiz tienen que referenciarse al cargar o activar *PF*, no se pueden añadir dinámicamente.
 - Por defecto, sólo existe un *anchor* raiz, que es `com.apple/*`
 - Se pueden añadir *anchors* dinámicamente si se anidan a un anchor que ya exista.
 
Teniendo en cuenta lo anterior, la mejor forma de hacer uso de *PF*, sin interferir con el resto de aplicaciones y servicios de *macOS*, es:

- Activarlo y guardar el *token*: `pfctl -E`
- Anidar un nuevo *anchor* con reglas: `pfctl -a com.apple/OpenVPN -f OpenVPN.rules`
- Si se quisiese desactivar: `pfctl -X <token>`

El contenido de `OpenVPN.rules` podría ser similar al siguiente:

```bash
int_if=utun0
ext_if=en0

# NAT rules
nat log on $ext_if from $int_if:network to any -> ($ext_if) 

# Filtering rules
pass in quick on $int_if inet from $int_if:network to any
block return in quick on $ext_if inet from any to $int_if:network
```

Estas reglas de ejemplo permitirían a los clientes de la *VPN* acceder a cualquier destino, incluido *Internet*, mientras que los equipos de la red privada no tendrían acceso a los clientes a través del túnel. 

#### Script de *OpenVPN*
Lo ideal sería automatizar todos los ajustes anteriores para que tengamos nuestro servidor totalmente operativo en cada reinicio. La forma más conveniente para lograrlo es crear un script que el servidor *OpenVPN* ejecute al iniciarse.

Para ello, necesitamos añadir algunas opciones al final del fichero de configuración de *OpenVPN*, que *Tunnelblick* localiza en `/Library/Application\ Support/Tunnelblick/Shared/server.tblk/Contents/Resources/config.ovpn`:

```bash
# Allow calling of built-in executables and user-defined scripts
script-security 2

# run a script when the connection is set up
# - pfctl for filtering/NAT
# - DDNS for dynamic IP address
up "/usr/local/bin/OpenVPN_server.sh"
```

Además, necesitamos crear el script `/usr/local/bin/OpenVPN_server.sh`:

```bash
#!/bin/bash

#
# Script intended to be run after OpenVPN Server is up
# Absolute paths have to be used because of OpenVPN requirements
#

# Enable PF
/sbin/pfctl -E

# Add OpenVPN rules based on Apple anchor
/sbin/pfctl -a "com.apple/OpenVPN" -f /etc/pf.rules/pfovpn.rule

# NO-IP DDNS: update public IP address periodically
killall noip2
/usr/local/bin/noip2
```

Por último, nos quedaría darle permisos de ejecución al script anterior `chmod +x /usr/local/bin/OpenVPN_server.sh`

Algunos comandos últiles para hacer pruebas, sin tener que reiniciar el equipo, son:

- Troubleshooting de *OpenVPN*
 - `killall -TERM openvpn`
 - `launchctl unload /Library/LaunchDaemons/net.tunnelblick.tunnelblick.startup.server.plist`
 - `launchctl load /Library/LaunchDaemons/net.tunnelblick.tunnelblick.startup.server.plist`
 - `tail -f /Library/Application\ Support/Tunnelblick/Logs/*.log`
 - `log show | grep -i openvpn`
- Troubleshooting de *PF*
 - `pfctl -s all`
 - `pfctl -a "com.apple/OpenVPN" -F all`
 - `log show | grep -i pfctl`
 - [pfdump.sh](https://gist.github.com/vitaly/cd0024d232a3a134b00e5496e4e779b8)

Cuando hayamos comprobado que está todo correcto, por fin, podemos reiniciar el servidor y verificar que hace todo lo que debería de forma automática.

## Conclusiones

