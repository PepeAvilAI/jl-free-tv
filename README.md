# JL Free TV

Lista de canales que lee la app JL Free TV (Roku) al abrirse.

- `channels.json`: la lista que usa la app. Cada canal: `{"name": "...", "group": "...", "url": "https://....m3u8"}`.
- `channels.m3u`: la misma lista para VLC.
- `app/`: código de la app Roku (SceneGraph). Se instala con el Development Application Installer de la TV.

Para agregar o quitar canales basta con editar `channels.json` y hacer commit en `main`; la app toma el cambio la próxima vez que se abre (GitHub puede tardar unos minutos en servir la versión nueva). Si la app no puede descargar la lista, usa la que trae dentro del paquete.

Los enlaces vienen de directorios públicos (iptv-org) y de servicios gratuitos; no se incluyen relays anónimos ni canales de pago.
