$VM_NAAM_1, $VM_NAAM_2 = "Kwetsbare_Ubuntu_VM", "Hacker_Kali_VM"

$RES = $false
#$VM_FOLDER = $null #

function checkVMsExcists {
    if (Test-Path $VM_FOLDER) {
        Write-Host "De map $VM_FOLDER bestaat al." -foregroundcolor Yellow
        $keuze = Read-Host "`nWilt u de bestaande virtuele machines verwijderen? (j/n)"
        if ($keuze -notin @("j", "J", "ja", "Ja", "JA")) {
            Write-Host "Afsluiten zonder wijzigingen aan te brengen."
            exit 0
        }
        Write-Host "Verwijderen van bestaande virtuele machines..."
        VBoxManage unregistervm $VM_NAAM_1 --delete > $null 2>&1
        VBoxManage unregistervm $VM_NAAM_2 --delete > $null 2>&1
        Remove-Item -Recurse -Force $VM_FOLDER > $null 2>&1
        Write-Host "Bestaande virtuele machines zijn verwijderd." -foregroundcolor Green
        exit 0
    
    } 
}

if (! $env:USERPROFILE) {
    $VM_FOLDER = Join-Path $env:HOME "VMs_NPE"
    Write-Host "12313123" -ForegroundColor Red
}
else {
    $VM_FOLDER = Join-Path $env:USERPROFILE "VMs_NPE"
    $RES = $true
    Write-Host "123213" -ForegroundColor Blue
}

checkVMsExcists


New-Item -Path $VM_FOLDER -ItemType Directory

$VM_VDI_PAD_1 = Join-Path (Join-Path $VM_FOLDER "64bit") "Ubuntu 24.10 (64bit).vdi"
# $VM_VDI_PAD_2 = Join-Path $VM_FOLDER "Kali Linux 2024.3 (64bit).vdi"

$VM_GEBRUIKERSNAAM_1, $VM_GEBRUIKERSNAAM_2 = "osboxes", "osboxes.org"
$VM_PASSWOORD_1, $VM_PASSWOORD_2 = "osboxes.org", "osboxes.org"

write-Host "De volgende Virtuele Machines worden geinstalleerd en geconfigureerd:
    1. Kwetsbare VM Ubuntu 24.10 (64bit)`n    2. Hacker VM Kali Linux 2024.3 (64bit)"

Start-Sleep -Seconds 3

if ($RES) {
    Invoke-WebRequest -Uri "https://hogent-my.sharepoint.com/:u:/g/personal/fatlind_isufi_student_hogent_be/EcHq8yP1fO5Ms5mIhfwiPkMBOemVCiv94_LffmD_j78WSQ?download=1" `
        -OutFile $(Join-Path (Join-Path $env:USERPROFILE "Downloads") "deel1.7z") > $null 2>&1
    #Invoke-WebRequest -Uri "https://hogent-my.sharepoint.com/:u:/g/personal/fatlind_isufi_student_hogent_be/EbIggjbOMNpFsDRfylf9QGcB2eToYLgYh-yBIOu54u3ueA?download=1" `
      #  -OutFile $(Join-Path $VM_FOLDER "Downloads" "deel2.7z") > $null 2>&1
}
else {
    Invoke-WebRequest -Uri "https://hogent-my.sharepoint.com/:u:/g/personal/fatlind_isufi_student_hogent_be/EcHq8yP1fO5Ms5mIhfwiPkMBOemVCiv94_LffmD_j78WSQ?download=1" `
        -OutFile $(Join-Path (Join-Path $env:HOME "Downloads") "deel1.7z") > $null 2>&1
    #Invoke-WebRequest -Uri "https://hogent-my.sharepoint.com/:u:/g/personal/fatlind_isufi_student_hogent_be/EbIggjbOMNpFsDRfylf9QGcB2eToYLgYh-yBIOu54u3ueA?download=1" `
    #   -OutFile $(Join-Path $VM_FOLDER "Downloads" "deel2.7z") > $null 2>&1
}

Write-Host "[PROGRESS] [1/?] Download.." -ForegroundColor Green

Start-Sleep -Seconds 3

Write-Host "9999999" -ForegroundColor red

if ($RES) {
    $env:PATH += ";C:\Program Files\7-Zip\"
    7z x "$(Join-Path (Join-Path $env:USERPROFILE "Downloads") "deel1.7z")" "-o$VM_FOLDER"
    #7z x $(Join-Path $VM_FOLDER "Downloads" "deel2.7z") -o$(Join-Path $VM_FOLDER "2.7z")
}
else {
    7z x "$(Join-Path $env:HOME "Downloads" "deel1.7z")" "-o$VM_FOLDER"
    #7z x $(Join-Path $VM_FOLDER "Downloads" "deel2.7z") -o$(Join-Path $VM_FOLDER "2.7z")
}

Write-Host "[PROGRESS] [2/?] VDI's installed" -ForegroundColor Green

VBoxManage createvm --name $VM_NAAM_1 --basefolder $VM_FOLDER --groups "/NPE_g" --ostype Ubuntu_64 --register
#VBoxManage createvm --name $VM_NAAM_2 --basefolder $VM_FOLDER --groups "/NPE_g" --ostype Debian_64 --register

VBoxManage modifyvm $VM_NAAM_1 --memory 2048 --cpus 2 --vram 64 --nic1 intnet
#VBoxManage modifyvm $VM_NAAM_2 --memory 2048 --cpus 2 --vram 64 --nic1 intnet

VBoxManage storagectl $VM_NAAM_1 --name "SATA Controller" --add sata --controller IntelAhci
#VBoxManage storagectl $VM_NAAM_2 --name "SATA Controller" --add sata --controller IntelAhci

VBoxManage storageattach $VM_NAAM_1 --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $VM_VDI_PAD_1
#VBoxManage storageattach $VM_NAAM_2 --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $VM_VDI_PAD_2

VBoxManage modifyvm $VM_NAAM_1 --boot1 disk
#VBoxManage modifyvm $VM_NAAM_2 --boot1 disk

VBoxManage snapshot $VM_NAAM_1 take "Init fase" --description "Gebruikersnaam: $VM_GEBRUIKERSNAAM_1 Wachtwoord: $VM_PASSWOORD_1"
#VBoxManage snapshot $VM_NAAM_2 take "Init fase" --description "Gebruikersnaam: $VM_GEBRUIKERSNAAM_2 Wachtwoord: $VM_PASSWOORD_2"

VBoxManage startvm $VM_NAAM_1
#VBoxManage startvm $VM_NAAM_2


