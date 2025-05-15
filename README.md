# cyber-npe-opdracht

## algemeen

`deadline 18/05/23 - 18:00`
CVE (common vulnerability exposure):

- `CVE-2020-1938`. Netwerkdienst die we aanvallen is Apache Tomcat server.
- `Opstelling:`
  - **Kwetsbaar VM (Ubuntu, al dan niet een CLI of GUI)**: deze VM wordt via *automatisatie* geinstalleerd door middel van het VBoxManage commando in een batch/powershell (.bat/.ps1) script & bash/powershell (.sh/.ps1) script voor het downloaden en installeren van de volgende software:
    - kwetsbare 9.0.30 versie van Apache Tomcat (laatste versie voordat het gepatched werd)
    - [VDI Ubuntu](https://www.osboxes.org/ubuntu/)
    - Eventueel docker downloaden en installeren (is geen verplichting)
  - **Hacker VM (Kali, al dan niet een CLI of GUI)** : deze VM wordt via *automatisatie* geinstalleerd door middel van het VBoxManage commando in een batch/powershell (.bat/.ps1) script & de aanval zelf **mag** via automatisatie - bash/powershell (.sh/.ps1) - uitgevoerd worden maar is geen verplichting. De tools die worden gebruikt zijn het volgende:
    - nmap scan
    - python scripts
    - python commando zelf
    - [VDI Kali](https://www.osboxes.org/kali-linux/)
- `Testen`:
  - **Reproduceerbaarheid:** De docent moet door aan de hand van de scripts uit te voeren de omgevingen kunnen reproduceren. De VDI's downloaden zij zelf en moet je niet meeleveren.
- `Bij het indienen`:
  - **2 scripts** in een zip mapje
  - Er moet een **deployment handleiding (in pdf formaat)** voorzien worden. In een zip mapje
  - Een korte **samenvatting/cheatsheet (in pdf formaat)** van uit te voeren stappen om de aanval succesvoluit te voeren (de docent volgt deze stap voor stap). In een zip mapje
  - **een korte demo-video via Panopto met Webcam (waarin iedereen aanbod komt)**. Maximale duur is 10 minuten:
    - 3/4 minuten voor het automatisatie deel
    - 6/7 minuten voor het aanvallende deel
    - in commentaar geef je de link naar de Panopto video
    