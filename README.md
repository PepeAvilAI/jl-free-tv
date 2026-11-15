# JL Free TV

Catálogo que JL Free TV y JL Inicio (Roku) descargan al abrirse.

Actualizado el 2026-11-14: **4,975 entradas**.
Se conservaron las 351 anteriores y se añadieron 4,624
señales de 165 países, con 158
idiomas declarados en las fichas de origen. Las nuevas entradas se agrupan por
país y categoría. Son cantidades de señales/feed, no un censo mundial de canales.

- `channels.json`: lista que consume la aplicación (`name`, `group`, `url`, `country`, `country_name`).
- `channels.m3u`: la misma lista para reproductores compatibles.
- `catalog-info.json`: fecha, cantidades, procedencia y límites de verificación.
- `app/`: reproductor Roku original; JL Inicio integrado vive en el proyecto local.

## Comprobación

Las incorporaciones provienen del directorio público
[iptv-org](https://github.com/iptv-org/iptv) y su
[API](https://github.com/iptv-org/api). Se cruzaron streams, fichas, feeds y
blocklist, quitando URLs repetidas, canales adultos/cerrados/bloqueados,
restricciones geográficas marcadas, canales habitualmente de pago identificados,
relays conocidos y enlaces que necesitan cabeceras especiales que la app no envía.
Cada incorporación entregó un manifiesto HLS y video reconocido por ffprobe.
Las señales que no emiten todo el día se identifican en el nombre.

Las pruebas se hicieron desde la PC en su conexión actual. No demuestran que todas
las señales funcionen desde la TV con salida VPN en otro país, ni disponibilidad
futura o autorización individual de cada enlace CDN. El directorio es comunitario;
no constituye una lista completa de todas las emisiones gratuitas del mundo.
No se contrató ningún servicio ni se eludieron restricciones o accesos de pago.
Los 351 canales anteriores se conservaron sin revalidación completa.

## Actualización en la TV

La aplicación obtiene `channels.json` de `main` al iniciarse. Volver a abrir
JL Inicio permite descargar el catálogo nuevo; GitHub puede tardar unos minutos
en servir la revisión. Si no puede descargarlo, queda la copia del paquete
instalado (351 canales hasta una futura reinstalación).

## País de cada señal

Desde el 15 de noviembre de 2026, todas las entradas incluyen `country` y
`country_name`, para navegar por país sin interpretar la categoría del canal.
Se clasificaron también los 351 anteriores, conservando nombres, categorías,
URLs y orden. Hay 165 países y territorios, con México y Estados Unidos como
accesos prioritarios en el menú nuevo. Los reproductores que solo leen
`name`, `group` y `url` siguen usando la misma lista.
