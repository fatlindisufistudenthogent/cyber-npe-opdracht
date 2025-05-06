# Instellingen
$VM_NAAM_1="Kwetsbare_Ubuntu_VM"
$VM_NAAM_2="Hacker_Kali_VM"

$VM_FOLDER="$env:USERPROFILE\VMs_NPE"
$VM_VDI_PAD_1="$VM_FOLDER\Ubuntu 24.10 (64bit).vdi"
$VM_VDI_PAD_2="$VM_FOLDER\Kali Linux 2024.3 (64bit).vdi"

$VM_GEBRUIKERSNAAM_1="osboxes"
$VM_PASSWOORD_1="osboxes.org"
$VM_GEBRUIKERSNAAM_2="osboxes.org"
$VM_PASSWOORD_2="osboxes.org"

$ANSWER=$($env:PATH -split ';' | Where-Object { $_ -like "*Oracle*" })
if (-not $ANSWER) {
    Write-Host "De Oracle VirtualBox is niet gevonden in de PATH-variabele.`nZorg ervoor dat VirtualBox correct is geïnstalleerd."
    exit 0
}

if (-Not (Test-Path $VM_FOLDER)) {
    New-Item -ItemType Directory -Path $VM_FOLDER > $null 2>&1
} else {
    Write-Host "De map $VM_FOLDER bestaat al." -foregroundcolor Yellow
    $keuze = Read-Host "`nWilt u de bestaande virtuele machines verwijderen? (j/n)"
    if ($keuze -notin @("j", "J", "ja", "Ja", "JA")) {
        Write-Host "Afsluiten zonder wijzigingen aan te brengen."
        exit 0
    }
    Write-Host "Verwijderen van bestaande virtuele machines..."
    VBoxManage.exe unregistervm $VM_NAAM_1 --delete > $null 2>&1
    VBoxManage.exe unregistervm $VM_NAAM_2 --delete > $null 2>&1
    Remove-Item -Recurse -Force $VM_FOLDER 
    Write-Host "Bestaande virtuele machines zijn verwijderd." -foregroundcolor Green
    exit 0
}

#Copy-Item "$env:USERPROFILE\Downloads\64bit\64bit\Ubuntu 24.10 (64bit).vdi" -Destination $VM_FOLDER
#Copy-Item "$env:USERPROFILE\Downloads\64bit (1)\64bit\Kali Linux 2024.3 (64bit).vdi" -Destination $VM_FOLDER

Copy-Item "$env:USERPROFILE\Desktop\Jaar 2\Semester 2\Cybersecurity\Ubuntu 24.10 (64bit).vdi" -Destination $VM_FOLDER # Dit is Jamie zijn locatie
Copy-Item "$env:USERPROFILE\Desktop\Jaar 2\Semester 2\Cybersecurity\Kali Linux 2024.3 (64bit).vdi" -Destination $VM_FOLDER # Dit is Jamie zijn locatie

VBoxManage.exe createvm --name $VM_NAAM_1 --basefolder $VM_FOLDER --groups "/NPE_g" --ostype Ubuntu_64 --register
VBoxManage.exe createvm --name $VM_NAAM_2 --basefolder $VM_FOLDER --groups "/NPE_g" --ostype Debian_64 --register

VBoxManage.exe modifyvm $VM_NAAM_1 --memory 2048 --cpus 2 --vram 64 --nic1 intnet
VBoxManage.exe modifyvm $VM_NAAM_2 --memory 2048 --cpus 2 --vram 64 --nic1 intnet

VBoxManage.exe storagectl $VM_NAAM_1 --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage.exe storagectl $VM_NAAM_2 --name "SATA Controller" --add sata --controller IntelAhci

VBoxManage.exe storageattach $VM_NAAM_1 --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $VM_VDI_PAD_1
VBoxManage.exe storageattach $VM_NAAM_2 --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $VM_VDI_PAD_2

VBoxManage.exe modifyvm $VM_NAAM_1 --boot1 disk
VBoxManage.exe modifyvm $VM_NAAM_2 --boot1 disk

VBoxManage.exe snapshot $VM_NAAM_1 take "Init fase" --description "Gebruikersnaam: $VM_GEBRUIKERSNAAM_1 Wachtwoord: $VM_PASSWOORD_1"
VBoxManage.exe snapshot $VM_NAAM_2 take "Init fase" --description "Gebruikersnaam: $VM_GEBRUIKERSNAAM_2 Wachtwoord: $VM_PASSWOORD_2"

VBoxManage.exe startvm $VM_NAAM_1
VBoxManage.exe startvm $VM_NAAM_2
