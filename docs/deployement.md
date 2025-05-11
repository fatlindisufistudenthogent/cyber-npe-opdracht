# Uitrol

## Doel en overzicht: Beschrijft de software of het systeem dat wordt geïmplementeerd. Doelen van de deployment (bijv. nieuwe versie, bugfixes, etc.).

## Systeemvereisten: Hardware- en softwarevereisten (bijv. besturingssysteem, geheugen, schijfruimte, etc.). Externe afhankelijkheden (bijv. andere software, netwerkinstellingen, databases).

Voor te installeren hebben we twee scripts voorzien

1. init.ps1; deze werkt enkel op Windows + voor als u de vdi's al op uw computer heeft staan: u moet zelf vdi's in de desbetreffende pad zetten namelijk:
   - \user\ [naam_gebruiker]\Downloads\64bit\64bit\ [vdi]) voor eerste vdi
   - \user\ [naam_gebruiker]\Downloads\64bit (1)\64bit\ [vdi] voor tweede vdi
2. 2init.ps1; deze werkt zowel op Windows als Linux + dit is een complete automatisatie: u hoeft niets te doen (vdi's worden van uit het internet afgehaald en geplaatst in het correcte pad)

In deze installatie wordt er gebruik gemaakt van

- Ubuntu 24.10 (64bit) vdi en
- Kali Linux 2024.3 (64bit) vdi

**Opgelet**: Zorg ervoor dat deze vdi's niet reeds op uw computer staan om conflicten te vermijden. 

Voor alles te deinstalleren voert u het script nog een keer uit in de terminal, er wordt om bevestiging gevraagd.

...

## Installatie-instructies: Stap-voor-stap instructies voor het installeren van de software. Waar de bestanden te vinden zijn (bijv. downloadlink, locatie van installatiebestanden). Vereiste rechten voor installatie (bijv. beheerdersrechten).

- Ubuntu 24.10 (64bit) vdi -> 
- Kali Linux 2024.3 (64bit) vdi -> https://sourceforge.net/projects/osboxes/files/v/vb/25-Kl-l-x/2024.3/64bit.7z/download

## Configuratie-instellingen: Configuratie-instellingen die mogelijk moeten worden aangepast om de software goed te laten functioneren. Aanpassingen aan netwerkconfiguraties, databases, services, of beveiligingsinstellingen.

- Ubuntu VM ->

- Kali VM ->

## Testen: Richtlijnen voor het testen van de geïnstalleerde software om ervoor te zorgen dat deze werkt zoals verwacht. Eventuele testscenario’s of validatie van functionaliteit.

Nu dat de virtuele machines correct geinstalleerd staan, gaan we beginnen met deze op te starten.

1) Start de Ubuntu VM.
2) Het wachtwoord is osboxes.org
3) (indien je wil kan je de instellingen verander voor het toetsenbord zodat het makkelijker is om de commando's uit te voeren)
      3.1) ga naar instellingen -> toetsenbord -> 
4) open de terminal en voer de volgende commando's uit
5) sudo apt install openssh-server -y
6) sudo systemctl start ssh
7) sudo systemctl enable ssh
8) mkdir ghostcat
(kijk welk ip adres de ubuntu vm heeft)
9) ip a 
(De 2 bestanden kopieren naar Ubuntu (gebruik jouw eigen pad en ip van de vms))

10) scp C:/Users/[gebruiker]/cyber-npe-opdracht/scripts/bash/setup_tomcat.sh osboxes@[ip adres van de vm]:~/ghostcat/setup_tomcat.sh
11) scp C:/Users/[gebruiker]/cyber-npe-opdracht/scripts/dockerfile/Dockerfile osboxes@[ip adres van de vm]:~/ghostcat/Dockerfile
12) chmod +x  setup_tomcat.sh
13) ./setup_tomcat.sh
(het ip adres van de ubuntu vm)
14) curl http://[ip adres van de vm]:8080/

## Rollback-plan: Instructies voor wat te doen als er iets misgaat tijdens de implementatie (bijv. hoe je terug kunt keren naar de vorige versie). Back-upprocedures.

## Ondersteuning en foutoplossing: Veelvoorkomende problemen en oplossingen. Contactinformatie voor technische ondersteuning.

## Versiebeheer: Versie-informatie van de geïmplementeerde software. Veranderingen of nieuwe functies in de versie die wordt gedeployed.

## Schaling en onderhoud: Hoe het systeem kan worden opgeschaald of uitgebreid. Instructies voor regelmatige onderhoudstaken of updates na de deployment.
