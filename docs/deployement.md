# Uitrol

## 1) Belangrijk om te weten

### Installatie

Voor te installeren van de virtuele machines (vms) hebben we twee scripts voorzien namelijk:

- init_1.ps1
- init_2.ps1

Voor de virtuele harde schijven (vdi's) hebben het volgende gebruikt:

- Ubuntu 24.10 (64bit) -> <https://www.osboxes.org/ubuntu/>
- Kali Linux 2024.3 (64bit) -> <https://www.osboxes.org/kali-linux/>

Het eerste script `init_1.ps1` werd gemaakt volgends de verwachtingen van de lector. Bij het uitvoeren van deze script krijgt de gebruiker een waarschuwingsbericht om te melden dat de uitvoer helemaal **afhankelijk** is van de gebruiker. Dat wil zeggen dat de vdi's vooraf geinstalleerd
moet zijn geweest en geplaatst worden in een specifieke locatie namelijk het pad: `C:\Users\<Gebruikersnaam>\Downloads`. Is dit niet gedaan, dan
krijgt de gebruiker de kans om dit te doen voordat de script kan starten. Omwille van deze lastige beperkingen, heb ik besloten een tweede variant van het script te maken.

Het tweede script `init_2.ps1` werd gemaakt als *uitbreiding* op de eerste script. Bij het uitvoeren van deze script krijgt de gebruiker een waarschuwingsbericht om te melden dat alles geautomatiseerd zal verlopen, de uitvoer zal helemaal **onafhankelijk** zijn van de gebruiker en is `pad locatie onafhankelijk`. Hiervoor heb ik de vdi's vooraf op OneDrive geupload en vanaf daar in PowerShell (PS) een request te doen (het zijn originele vdi's maar vanwege een timer blokkade op de sourceforge site kon PS hier niet goed mee omgaan).

**Opgelet**: Zorg ervoor dat deze vdi's niet reeds op uw computer staan en gebruikt worden door VirtualBox. VirtualBox geeft aan elke vdi een unieke UUID waardoor bij eenzelfde vdi conflicten gebeuren.

*Om deze scripts overzichtelijk te houden is er bewust besloten om foutmeldingen tijdens de installaties te negeren. Indien er fouten gebeuren tijdens de installaties kan de gebruiker gewoonweg het script opnieuw/tweede keer uitvoeren, en dan krijgt de gebruiker de kans om alles te verwijderen/ongedaan maken.*

 Voor de vms setup is er gebruik gemaakt van een NatNetwerk (NN). De NN biedt een geisoleerde omgeving waarin de vms met elkaar kunnen communiceren aan de hand van ip addressen die op statische wijze worden geconfigureerd. Dit is omdat bij het NN twee port forwarding regels zijn geconfigureerd geweest bij de installatie van het NN en de vms (zie uitleg hierboven). We doen dit omdat we commando's zoals `ssh/scp` willen gebruiken vanaf onze host machine. Dit is handiger dan een sharedfolder of dergelijks. Er zijn twee shell scripts voorzien namelijk:

- init_ubuntu.sh
- init_kali.sh

Beide scripts hebben als doel om hun ip addressen te configureren op hun bijhorende interface. Niet alleen dat maar ook ssh en de toetsenbord instelling worden daarmee geinstalleerd & geconfigureerd.

Voor het uitvoeren van de shell scripts moeten die reeds aanwezig zijn op de vms. Er kan gekozen worden om de inhoud handmatig te kopieren en plakken. Vanwege de beperking met VboxManage commando's was het niet mogelijk om deze al pre-installed te krijgen op de vms. Alhoewel er creatief werd nagedacht over een oplossing was het helaas niet gelukt.

*Mededeling: enkel bij ubuntu is het niet gelukt om via de terminal de toetsenbord instelling te wijzigen. Wij vermoeden dat dit niet aan ons ligt maar aan osboxes zelf.*

<!-- @ Jamie @ Joeri
toon hier de aanval kort of dingen die belangrijk zijn om te weten
 -->

## 2) Virtuele omgeving vervolledigen (netwerk adapters)

- zorg dat het init_kali.sh bestand is gedownload op je host
- zorg dat het init_ubuntu.sh bestand is gedownload op je host
- zorg dat het setup_tomcat.sh bestand is gedownload op je host
- zorg dat het Dockerfile.txt bestand is gedownload op je host

- geef in virtualbox de kali vm een gedeelde map waarin dit init_kali.sh bestand in zit

- geef in virtualbox de ubuntu vm een gedeelde map waarin dit init_ubuntu.sh en setup_tomcat.sh en Dockerfile.txt in zit

- start de ubuntu vm
- open terminal in de ubuntu vm
- voer volgende commando's uit in ubuntu vm:

- 2.1) sudo cp /media/sf_ubuntu/init_ubuntu.sh ~/Desktop/
- 2.2) sudo cp /media/sf_ubuntu/setup_tomcat.sh ~/Desktop/
- 2.3) sudo cp /media/sf_ubuntu/Dockerfile.txt ~/Desktop/
- 2.4) cd Desktop
- 2.5) sudo apt install openssh-server -y
- 2.6) sudo systemctl start ssh
- 2.7) sudo systemctl enable ssh
- 2.8) sudo chmod +x init_ubuntu.sh
- 2.9) sudo ./init_ubuntu.sh
- 2.10) ip -br a
- Dit is wat de uitvoer zou moeten zijn:
- ![image](https://github.com/user-attachments/assets/66d4f478-f46a-499b-9666-0baf2522c86b)
- start nu de kali vm (laat de ubuntu vm aan)
- open terminal in de kali vm
- voer volgende commando's uit in kali vm:
- 2.11) sudo cp /media/sf_kali/init_kali.sh ~/Desktop/
- 2.12) cd Desktop
- 2.13) sudo chmod +x init_kali.sh
- 2.14) sudo ./init_kali.sh
- 2.15) ip -br a
- Dit is wat de uitvoer zou moeten zijn:
- ![image](https://github.com/user-attachments/assets/d9b2301a-cd19-44c2-866a-a70e949028c7)
- in kali vm voer volgend commando uit om te controleren of je kan pingen naar ubuntu vm:
- 2.16) ping 10.10.10.4
- in ubuntu vm voer volgend commando uit om te controleren of je kan pingen naar kali vm:
- 2.17) ping 10.10.10.3
- controleer nu ook of beide vm's toegang hebben tot het internet
- ga nu terug naar de ubuntu vm en voer de volgende commando's uit
- 2.18) sudochmod +x setup_tomcat.sh
- 2.19) sudo ./setup_tomcat.sh
- controleer nu in een browser of je ook deze Tomcat-container draait op poort 8080 -> http://10.10.10.4:8080

## Ondersteuning en foutoplossing: Veelvoorkomende problemen en oplossingen. Contactinformatie voor technische ondersteuning

indien er een probleem zou zijn met het ip adres kan je deze zelf aanpassen zodat je zeker bent welk ip adres je hebt via volgende stappen:

in ubuntu:

   1) ga naar het netwerkicoon
   2) open de netwerkinstellingen
   3) selecteer Wired
   4) selecteer bewerken
   5) ga naar IPv4
   6) selecteer handmatig
   7) kies nu een ip adress die je aan de ubuntu vm wil geven (voorbeeld: 10.10.10.4)
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
   7) kies nu een ip adress die je aan de kali vm wil geven (voorbeeld: 10.10.10.5)
   8) stel de subnetmask in met 255.255.255.0
   9) stel de DNS-server in met 8.8.8.8
   10) controleer nu in terminal met commando "ip a" of dit adres ook klopt

## Versiebeheer: Versie-informatie van de geïmplementeerde software. Veranderingen of nieuwe functies in de versie die wordt gedeployed

## Schaling en onderhoud: Hoe het systeem kan worden opgeschaald of uitgebreid. Instructies voor regelmatige onderhoudstaken of updates na de deployment

## rest
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

