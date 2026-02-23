# UTEL — Asterisk ARI outbound call bridge

[TASK](https://telegra.ph/Asterisk-ARI-va-Laravel-topshiriq-02-17)

Qisqacha: PHP skript ARI orqali kiruvchi qo'ng'iroqlarni javoblab, outbound kanallar ochib, mixing bridge ichida birlashtiradi.

Talablar
- Docker va docker-compose

Tez boshlash
1. Konfiguratsiyalarni tekshiring:
   - ARI va Asterisk sozlamalari: [asterisk/ari.conf](asterisk/ari.conf), [asterisk/pjsip.conf](asterisk/pjsip.conf), [asterisk/http.conf](asterisk/http.conf), [asterisk/rtp.conf](asterisk/rtp.conf)
   - Kanal extension va dialplan: [asterisk/extensions.conf](asterisk/extensions.conf)

2. Docker orqali ishga tushirish:
```markdown
# loyiha ildizida
docker compose up -d --build
```
 docker-compose konfiguratsiyasi: [docker-compose.yaml](docker-compose.yaml)  
 Dockerfile: [Dockerfile](Dockerfile)

Skript va dependency
- Auto-loader va paketlar Composer orqali o'rnatiladi: [composer.json](composer.json) (skript `up` run qiladi).
- Asosiy ishchi skript: [call](call)

Skript ichidagi muhim funksiyalar
- [`logger`](call) — log yozadi (call.log).
- [`uuid`](call) — unique id hosil qiladi.
- [`request`](call) — ARI REST so'rovlarini ta'minlaydi.
- [`connectWs`](call) — ARI WebSocket-ga ulanadi va eventlarni oladi.

Qanday ishlaydi
- Skript ARI WebSocket-ga ulanib, StasisStart voqealarini kutadi.
- Kiruvchi kanalni answer qiladi, mixing bridge yaratadi va inbound kanalni unga qo'shadi.
- Outbound kanal uchun yangi channel yaratib, ARI orqali PJSIP/EXTEN ga qo'ng'iroq qiladi (appArgs orqali "out,<bridgeId>,<inboundId>").
- Kanal tugaganda bridge va outbound channel tozalanadi.

Fayllar va joylashuv
- Skript va dependency: [call](call), [composer.json](composer.json), vendor katalogi (gitignore qilingan).
- Asterisk konfiguratsiyalari: [asterisk/ari.conf](asterisk/ari.conf), [asterisk/pjsip.conf](asterisk/pjsip.conf), [asterisk/http.conf](asterisk/http.conf), [asterisk/rtp.conf](asterisk/rtp.conf), [asterisk/extensions.conf](asterisk/extensions.conf)
- Docker compose: [docker-compose.yaml](docker-compose.yaml)
- Dockerfile: [Dockerfile](Dockerfile)

Loglar
- Skript logi: call.log (projekt ildizida)
- Asterisk logi (yuqorida volume bilan bog'langan): [asterisk/logs/messages.log](asterisk/logs/messages.log)

Muammolarni tuzatish
- ARI WS ulanmasa, skript logga yozadi va qayta urinadi — [call](call) ichidagi WS reconnect mantiqiga qarang.
- PJSIP reg va autentifikatsiyani tekshiring: [asterisk/pjsip.conf](asterisk/pjsip.conf)
