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
  - Er moet een **[deployment handleiding (in pdf formaat)](#extra-uitleg)** voorzien worden. In een zip mapje
  - Een korte **samenvatting/cheatsheet (in pdf formaat)** van uit te voeren stappen om de aanval succesvoluit te voeren (de docent volgt deze stap voor stap). In een zip mapje
  - **een korte demo-video via Panopto met Webcam (waarin iedereen aanbod komt)**. Maximale duur is 10 minuten:
    - 3/4 minuten voor het automatisatie deel
    - 6/7 minuten voor het aanvallende deel
    - in commentaar geef je de link naar de Panopto video

## extra uitleg

1. Doel en overzicht:
Beschrijft de software of het systeem dat wordt geïmplementeerd.
Doelen van de deployment (bijv. nieuwe versie, bugfixes, etc.).

2. Systeemvereisten:
Hardware- en softwarevereisten (bijv. besturingssysteem, geheugen, schijfruimte, etc.).
Externe afhankelijkheden (bijv. andere software, netwerkinstellingen, databases).

3. Installatie-instructies:
Stap-voor-stap instructies voor het installeren van de software.
Waar de bestanden te vinden zijn (bijv. downloadlink, locatie van installatiebestanden).
Vereiste rechten voor installatie (bijv. beheerdersrechten).

4. Configuratie-instellingen:
Configuratie-instellingen die mogelijk moeten worden aangepast om de software goed te laten functioneren.
Aanpassingen aan netwerkconfiguraties, databases, services, of beveiligingsinstellingen.

5. Testen:
Richtlijnen voor het testen van de geïnstalleerde software om ervoor te zorgen dat deze werkt zoals verwacht.
Eventuele testscenario’s of validatie van functionaliteit.

6. Rollback-plan:
Instructies voor wat te doen als er iets misgaat tijdens de implementatie (bijv. hoe je terug kunt keren naar de vorige versie).
Back-upprocedures.

7. Ondersteuning en foutoplossing:
Veelvoorkomende problemen en oplossingen.
Contactinformatie voor technische ondersteuning.

8. Versiebeheer:
Versie-informatie van de geïmplementeerde software.
Veranderingen of nieuwe functies in de versie die wordt gedeployed.

9. Schaling en onderhoud:
Hoe het systeem kan worden opgeschaald of uitgebreid.
Instructies voor regelmatige onderhoudstaken of updates na de deployment.
