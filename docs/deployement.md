# Uitrol

## 1) Belangrijk om te weten

### Installatie

Voor te installeren van de virtuele machines (vms) hebben we twee scripts voorzien namelijk:

- init_1.ps1
- init_2.ps1

Voor de virtuele harde schijven (vdi's) hebben het volgende gebruikt:

- Ubuntu 24.10 (64bit)
- Kali Linux 2024.3 (64bit)

Het eerste script `init_1.ps1` werd gemaakt volgends de verwachtingen van de lector. Bij het uitvoeren van deze script krijgt de gebruiker een waarschuwingsbericht om te melden dat de uitvoer helemaal **afhankelijk** is van de gebruiker. Dat wil zeggen dat de vdi's vooraf geinstalleerd
moet zijn geweest en geplaatst worden in een specifieke locatie namelijk het pad: `C:\Users\<Gebruikersnaam>\Downloads`. Is dit niet gedaan, dan
krijgt de gebruiker de kans om dit te doen voordat de script kan starten. Omwille van deze lastige beperkingen, heb ik besloten een tweede variant van het script te maken.

Het tweede script `init_2.ps1` werd gemaakt als *uitbreiding* op de eerste script. Bij het uitvoeren van deze script krijgt de gebruiker een waarschuwingsbericht om te melden dat alles geautomatiseerd zal verlopen, de uitvoer zal helemaal **onafhankelijk** zijn van de gebruiker en is `pad locatie onafhankelijk`. Hiervoor heb ik de vdi's vooraf op OneDrive geupload en vanaf daar in PowerShell (PS) een request te doen (het zijn originele vdi's maar vanwege een timer blokkade op de sourceforge site kon PS hier niet goed mee omgaan).

**Opgelet**: Zorg ervoor dat deze vdi's niet reeds op uw computer staan en gebruikt worden door VirtualBox. VirtualBox geeft aan elke vdi een unieke UUID waardoor bij eenzelfde vdi conflicten gebeuren.

*Om deze scripts overzichtelijk te houden is er bewust besloten om foutmeldingen tijdens de installaties te negeren. Indien er fouten gebeuren tijdens de installaties kan de gebruiker gewoonweg het script opnieuw/tweede keer uitvoeren, en dan krijgt de gebruiker de kans om alles te verwijderen/ongedaan maken.*

 Voor de vms setup is er gebruik gemaakt van een NatNetwerk (NN). De NN biedt een geisoleerde omgeving waarin de vms met elkaar kunnen communiceren aan de hand van ip addressen die op statische wijze worden geconfigureerd. Dit is omdat bij het NN twee port forwarding regels zijn geconfigureerd geweest bij de installatie van het NN en de vms (zie uitleg hierboven). We doen dit omdat we commando's zoals `ssh/scp` willen gebruiken vanaf onze host machine. Dit is handiger dan een sharedfolder of dergelijks. Er zijn twee shell scripts voorzien namelijk:

- `init_ubuntu.sh`
- `init_kali.sh`

Beide scripts hebben als doel om hun ip addressen te configureren op hun bijhorende interface. Niet alleen dat maar ook ssh en de toetsenbord instelling worden daarmee geinstalleerd & geconfigureerd.

Voor het uitvoeren van de shell scripts moeten die reeds aanwezig zijn op de vms. Er kan gekozen worden om de inhoud handmatig te kopieren en plakken. Vanwege de beperking met VboxManage commando's was het niet mogelijk om deze al pre-installed te krijgen op de vms. Alhoewel er creatief werd nagedacht over een oplossing was het helaas niet gelukt.

*Mededeling: enkel bij ubuntu is het niet gelukt om via de terminal de toetsenbord instelling te wijzigen. Wij vermoeden dat dit niet aan ons ligt maar aan osboxes zelf.*

<!-- @ Jamie @ Joeri
toon hier de aanval kort of dingen die belangrijk zijn om te weten
 -->

## 2) Virtuele omgeving vervolledigen (netwerk adapters)

<!-- @ Jamie -->

## 3) Starten van de opdracht (UBUNTU VM)

Nu we een correcte virtuele omgeving hebben in beide VM's kunnen we beginnen aan de opdracht zelf. Hierbij gaan we dus nog een paar commando's uitvoeren.

- 3.1) Start de ubuntu vm:
- 3.2) open terminal

- voer volgende commando's in:

- 3.3) sudo apt install openssh-server -y
- 3.4) sudo systemctl start ssh
- 3.5) sudo systemctl enable ssh
- 3.6) mkdir ghostcat
- 3.7) cd ghostcat
- 3.8) chmod +x setup_tomcat.sh
- 3.9) sudo ./setup_tomcat.sh
- controleer nu in een browser of je ook deze Tomcat-container draait op poort 8080 -> http://[ip adres van de ubuntu vm]:8080



Systeemvereisten om de installaties van de vms succesvol te verlopen:

- Besturingsysteemflexibiliteit: zowel op `Windows als Linux` kan dit gebruikt worden
- Verbruik per vm:
      - `RAM:` 2048MB (2GB)
      - `CPU:` 2cpus
      - `VRAM:` 64MB
- Schijfruimte:
      - `Ubuntu:` ........
      - `Kali:` .....
- Software:
      - `Oracle Virtual Box`
      - `ssh`
- Optioneel:
      - `Ubuntu Osboxes vdi:` 64bit
      - `Kali Osboxes vdi:` 64bit
## 4) Starten van de opdracht (KALI VM)

- 4.1) Start de kali vm:
- 4.2) open terminal
- 4.3) sudo systemctl start ssh
- 4.4) sudo systemctl enable ssh
- 4.5) sudo chmod +x exploit_ghostcat.py

## Installatie-instructies: Stap-voor-stap instructies voor het installeren van de software. Waar de bestanden te vinden zijn (bijv. downloadlink, locatie van installatiebestanden). Vereiste rechten voor installatie (bijv. beheerdersrechten)

Installaties van de benodigde software kan je hieronder telkens vinden:

- Oracle Virtual Box: <https://www.virtualbox.org/wiki/Downloads>
- SSH: .......... <!-- hoe ?-->
- Optioneel: Ubuntu 24.10 64bit vdi: <https://www.osboxes.org/ubuntu/>
- Optioneel: Kali Linux 2024.3 64bit vdi: <https://www.osboxes.org/kali-linux/>

## Configuratie-instellingen: Configuratie-instellingen die mogelijk moeten worden aangepast om de software goed te laten functioneren. Aanpassingen aan netwerkconfiguraties, databases, services, of beveiligingsinstellingen

<!-- @ Jamie -->

- Ubuntu VM ->

- Kali VM ->

## Testen: Richtlijnen voor het testen van de geïnstalleerde software om ervoor te zorgen dat deze werkt zoals verwacht. Eventuele testscenario’s of validatie van functionaliteit

Nu dat de virtuele machines correct geinstalleerd staan, gaan we beginnen met deze op te starten.

START DE UBUNTU VM

1. Het wachtwoord is osboxes.org
<!-- @ CLI ! of script
2. (indien je wil kan je de instellingen verander voor het toetsenbord zodat het makkelijker is om de commando's uit te voeren)
      2.1) ga naar instellingen -> toetsenbord ->
-->

<!-- @ Deze zouden door init.sh scripts uitgevoerd worden: sudo chmod +x init_ubuntu.sh, sudo chmod +x init_kali.sh; .\init_ubuntu, .\init_kali.sh 
3) open de terminal en voer de volgende commando's uit
4) sudo apt install openssh-server -y
5) sudo systemctl start ssh
6) sudo systemctl enable ssh
7) mkdir ghostcat
8) ip a
-->

3. Open terminal
4. sudo chmod +x init_ubuntu.sh
5. sudo chmod +x init_kali.sh

(kijk welk ip adres de ubuntu vm heeft)
(De 2 bestanden kopieren naar Ubuntu (gebruik jouw eigen pad en ip van de vms))

**vanaf de host**

10) scp C:\Users\gebruiker\cyber-npe-opdracht\scripts\bash\setup_tomcat.sh osboxes@[ip adres van de ubuntu vm]:~/ghostcat/setup_tomcat.sh
11) scp C:\Users\[gebruiker]\cyber-npe-opdracht/scripts/dockerfile\Dockerfile osboxes@[ip adres van de ubuntu vm]:~/ghostcat/Dockerfile
12) chmod +x setup_tomcat.sh
13) .\setup_tomcat.sh

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

## Rollback-plan: Instructies voor wat te doen als er iets misgaat tijdens de implementatie (bijv. hoe je terug kunt keren naar de vorige versie). Back-upprocedures

## Ondersteuning en foutoplossing: Veelvoorkomende problemen en oplossingen. Contactinformatie voor technische ondersteuning

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
   10) controleer nu in terminal met commando "ip a" of dit adres ook klopt

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
   10) controleer nu in terminal met commando "ip a" of dit adres ook klopt

## Versiebeheer: Versie-informatie van de geïmplementeerde software. Veranderingen of nieuwe functies in de versie die wordt gedeployed

## Schaling en onderhoud: Hoe het systeem kan worden opgeschaald of uitgebreid. Instructies voor regelmatige onderhoudstaken of updates na de deployment
