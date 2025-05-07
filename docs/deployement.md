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

## Configuratie-instellingen: Configuratie-instellingen die mogelijk moeten worden aangepast om de software goed te laten functioneren. Aanpassingen aan netwerkconfiguraties, databases, services, of beveiligingsinstellingen.

## Testen: Richtlijnen voor het testen van de geïnstalleerde software om ervoor te zorgen dat deze werkt zoals verwacht. Eventuele testscenario’s of validatie van functionaliteit.

## Rollback-plan: Instructies voor wat te doen als er iets misgaat tijdens de implementatie (bijv. hoe je terug kunt keren naar de vorige versie). Back-upprocedures.

## Ondersteuning en foutoplossing: Veelvoorkomende problemen en oplossingen. Contactinformatie voor technische ondersteuning.

## Versiebeheer: Versie-informatie van de geïmplementeerde software. Veranderingen of nieuwe functies in de versie die wordt gedeployed.

## Schaling en onderhoud: Hoe het systeem kan worden opgeschaald of uitgebreid. Instructies voor regelmatige onderhoudstaken of updates na de deployment.
