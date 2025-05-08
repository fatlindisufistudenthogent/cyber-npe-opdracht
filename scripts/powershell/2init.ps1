$VM_NAAM_1, $VM_NAAM_2 = "Kwetsbare_Ubuntu_VM", "Hacker_Kali_VM"

$RES = $false

function checkVMsExcists {
    param(
        [string]$folder,
        [string]$vm_1,
        [string]$vm_2,
        [bool]$vbxnet_made
    )
    if (Test-Path $folder) {
        Write-Host "De map $folder bestaat al." -foregroundcolor Yellow
        $keuze = Read-Host "`nWilt u de bestaande virtuele machines en gerelateerde settings verwijderen? (j/n)"
        if ($keuze -notin @("j", "J", "ja", "Ja", "JA")) {
            Write-Host "Afsluiten zonder wijzigingen aan te brengen."
            exit 0
        }
        Write-Host "Verwijderen van bestaande virtuele machines en settings..."
        VBoxManage unregistervm $vm_1 --delete > $null 2>&1
        VBoxManage unregistervm $vm_2 --delete > $null 2>&1
        if ($vbxnet_made -eq $true) {
            VBoxManage hostonlyif remove "vboxnet0" > $null 2>&1
        }
        Remove-Item -Recurse -Force $folder > $null 2>&1
        if ($RES) {
            Remove-Item -Recurse -Force $(Join-Path (Join-Path $env:USERPROFILE "Downloads") "deel1.7z") > $null 2>&1
            Remove-Item -Recurse -Force $(Join-Path (Join-Path $env:USERPROFILE "Downloads") "deel2.7z") > $null 2>&1
        }
        else {
            Remove-Item -Recurse -Force $(Join-Path (Join-Path $env:HOME "Downloads") "deel1.7z") > $null 2>&1
            Remove-Item -Recurse -Force $(Join-Path (Join-Path $env:HOME "Downloads") "deel2.7z") > $null 2>&1
        }
        
        Write-Host "Bestaande virtuele machines en settings zijn verwijderd." -ForegroundColor Green
        exit 0
    
    } 
}

if (! $env:USERPROFILE) {
    $VM_FOLDER = Join-Path $env:HOME "VMs_NPE"
}
else {
    $VM_FOLDER = Join-Path $env:USERPROFILE "VMs_NPE"
    $RES = $true
}

$LIST_ONJECTS = $(vboxmanage list hostonlyifs | where-Object { $_ -match "Name:\s+vboxnet[0-9]" })
$VBXNET_MADE = $false
if ($LIST_ONJECTS.Count -eq "0") {
    VBoxManage hostonlyif create > $null 2>&1
    $VBXNET_MADE = $true
}

checkVMsExcists -folder $VM_FOLDER -vm_1 $VM_NAAM_1 -vm2 $VM_NAAM_2 -vbxnet_made $VBXNET_MADE

New-Item -Path $VM_FOLDER -ItemType Directory > $null 2>&1

$VM_VDI_PAD_1 = Join-Path (Join-Path $VM_FOLDER "64bit") "Ubuntu 24.10 (64bit).vdi"
$VM_VDI_PAD_2 = Join-Path (Join-Path $VM_FOLDER "64bit") "Kali Linux 2024.3 (64bit).vdi"

$VM_GEBRUIKERSNAAM_1, $VM_GEBRUIKERSNAAM_2 = "osboxes.org", "osboxes"
$VM_PASSWOORD_1, $VM_PASSWOORD_2 = "osboxes.org", "osboxes.org"

write-Host "De volgende Virtuele Machines worden geinstalleerd en geconfigureerd:
    1. Kwetsbare VM Ubuntu 24.10 (64bit)`n    2. Hacker VM Kali Linux 2024.3 (64bit)"

Start-Sleep -Seconds 3

Clear-Host

if ($RES) {
    Write-Host "[PROGRESS] [1/6] Downloaden van eerste 7zip map..."
    Invoke-WebRequest -Uri "https://hogent-my.sharepoint.com/:u:/g/personal/fatlind_isufi_student_hogent_be/EcHq8yP1fO5Ms5mIhfwiPkMBOemVCiv94_LffmD_j78WSQ?download=1" `
        -OutFile $(Join-Path (Join-Path $env:USERPROFILE "Downloads") "deel1.7z") > $null 2>&1

    Write-Host "[PROGRESS] [2/6] Downloaden van tweede 7zip map..."
    Invoke-WebRequest -Uri "https://hogent-my.sharepoint.com/:u:/g/personal/fatlind_isufi_student_hogent_be/EbIggjbOMNpFsDRfylf9QGcB2eToYLgYh-yBIOu54u3ueA?download=1" `
        -OutFile $(Join-Path (Join-Path $env:USERPROFILE "Downloads") "deel2.7z") > $null 2>&1
}
else {

    Write-Host "[PROGRESS] [2/6] Downloaden van tweede 7zip map..."
    Invoke-WebRequest -Uri "https://hogent-my.sharepoint.com/:u:/g/personal/fatlind_isufi_student_hogent_be/EbIggjbOMNpFsDRfylf9QGcB2eToYLgYh-yBIOu54u3ueA?download=1" `
        -OutFile $(Join-Path (Join-Path $env:HOME "Downloads") "deel2.7z") > $null 2>&1


    Write-Host "[PROGRESS] [1/6] Downloaden van eerste 7zip map..."
    Invoke-WebRequest -Uri "https://hogent-my.sharepoint.com/:u:/g/personal/fatlind_isufi_student_hogent_be/EcHq8yP1fO5Ms5mIhfwiPkMBOemVCiv94_LffmD_j78WSQ?download=1" `
        -OutFile $(Join-Path (Join-Path $env:HOME "Downloads") "deel1.7z") > $null 2>&1
}

if ($RES) {
    Write-Host "[PROGRESS] [3/6] Toevoegen van 7zip aan de omgevingsvariabele PATH..." > $null 2>&1
    $env:PATH += ";C:\Program Files\7-Zip\"
    Write-Host "[PROGRESS] [4/6] Uitpakken van eerste 7zip map..."
    7z x "$(Join-Path (Join-Path $env:USERPROFILE "Downloads") "deel1.7z")" "-o$VM_FOLDER" > $null 2>&1
    Write-Host "[PROGRESS] [5/6] Uitpakken van tweede 7zip map..."
    7z x "$(Join-Path (Join-Path $env:USERPROFILE "Downloads") "deel2.7z")" "-o$VM_FOLDER" > $null 2>&1
}
else {
    Write-Host "[PROGRESS] [3/6] Toevoegen van 7zip aan de omgevingsvariabele PATH..." > $null 2>&1
    $env:PATH += ":/usr/bin/7z"
    Write-Host "[PROGRESS] [5/6] Uitpakken van tweede 7zip map..."
    7z x "$(Join-Path $env:HOME "Downloads" "deel2.7z")" "-o$VM_FOLDER" > $null 2>&1

    Write-Host "[PROGRESS] [4/6] Uitpakken van eerste 7zip map..."
    7z x "$(Join-Path $env:HOME "Downloads" "deel1.7z")" "-o$VM_FOLDER" > $null 2>&1
}

Write-Host "VDI's geinstalleerd!" -ForegroundColor Green
Write-Host "[PROGRESS] [6/6] Virtuele machines aanmaken & configureren..."

VBoxManage createvm --name $VM_NAAM_1 --basefolder $VM_FOLDER --groups "/NPE_g" --ostype Ubuntu_64 --register > $null 2>&1
VBoxManage createvm --name $VM_NAAM_2 --basefolder $VM_FOLDER --groups "/NPE_g" --ostype Debian_64 --register > $null 2>&1

VBoxManage modifyvm $VM_NAAM_1 --memory 2048 --cpus 2 --vram 64 --nic1 intnet > $null 2>&1
VBoxManage modifyvm $VM_NAAM_2 --memory 2048 --cpus 2 --vram 64 --nic1 intnet --nic2 hostonly --hostonlyadapter2 "vboxnet0" > $null 2>&1

VBoxManage storagectl $VM_NAAM_1 --name "SATA Controller" --add sata --controller IntelAhci > $null 2>&1
VBoxManage storagectl $VM_NAAM_2 --name "SATA Controller" --add sata --controller IntelAhci > $null 2>&1

VBoxManage storageattach $VM_NAAM_1 --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $VM_VDI_PAD_1 > $null 2>&1
VBoxManage storageattach $VM_NAAM_2 --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $VM_VDI_PAD_2 > $null 2>&1

VBoxManage modifyvm $VM_NAAM_1 --boot1 disk > $null 2>&1
VBoxManage modifyvm $VM_NAAM_2 --boot1 disk > $null 2>&1

VBoxManage snapshot $VM_NAAM_1 take "Init fase" --description "Gebruikersnaam: $VM_GEBRUIKERSNAAM_1 Wachtwoord: $VM_PASSWOORD_1" > $null 2>&1
VBoxManage snapshot $VM_NAAM_2 take "Init fase" --description "Gebruikersnaam: $VM_GEBRUIKERSNAAM_2 Wachtwoord: $VM_PASSWOORD_2" > $null 2>&1

Write-Host "Virtuele machines zijn aangemaakt!" -ForegroundColor Green

VBoxManage startvm $VM_NAAM_1 > $null 2>&1
VBoxManage startvm $VM_NAAM_2 > $null 2>&1

