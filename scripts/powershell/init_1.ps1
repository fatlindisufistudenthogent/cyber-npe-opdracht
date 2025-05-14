<#
    Dit script maakt gebruik van de VirtualBox command line interface (CLI) 
    om virtuele machines aan te maken en configureren. Het script controleert 
    of de benodigde VDI-bestanden aanwezig zijn in de opgegeven map 
    C:\Users\Gebruikersnaam\Downloads en maakt vervolgens de virtuele machines 
    aan met de juiste instellingen.
#>
$VM_NAAM_1, $VM_NAAM_2 = "Kwetsbare_Ubuntu_VM", "Hacker_Kali_VM"

$RES = $false

function checkVMsExcists {
    param(
        [string]$folder,
        [string]$vm_1,
        [string]$vm_2,
        [bool]$vbxnet_made,
        [string]$name_vbxnet,
        [bool]$res
    )
    if (Test-Path $folder) {
        Write-Host "WARINING: De map $folder bestaat al." -foregroundcolor DarkYellow
        $keuze = Read-Host "`nWilt u de bestaande virtuele machines en gerelateerde settings die enkel tijdens de
        installatie zijn gebeurd verwijderen? (j/n)"
        if ($keuze -notin @("j", "J", "ja", "Ja", "JA")) {
            Clear-Host
            Write-Host "Afsluiten zonder wijzigingen aan te brengen."
            exit 0
        }
        if ($res) {
            Clear-Host
            Get-Process | Where-Object { 
                $_.ProcessName -like "*VBox*" -or 
                $_.ProcessName -like "*VirtualBox*" } | Stop-Process -Force > $null 2>&1
            Write-Host "[$(Get-Date -Format "dd-MM-yyyy HH:mm:ss")] [1/3] Herplaatsen van de VDI's naar de \Downloads folder..."
            Move-Item -Path $folder `
                -Destination (Join-Path (Join-Path $env:USERPROFILE "Downloads") "Ubuntu 24.10 (64bit).vdi") > $null 2>&1
            Move-Item -Path $folder `
                -Destination (Join-Path (Join-Path $env:USERPROFILE "Downloads") "Kali Linux 2024.3 (64bit).vdi") > $null 2>&1

        }
        else {
            Clear-Host
            pkill -f VirtualBox > $null 2>&1
            Move-Item -Path $folder `
                -Destination (Join-Path (Join-Path $env:HOME "Downloads") "Ubuntu 24.10 (64bit).vdi") > $null 2>&1
            Move-Item -Path $folder `
                -Destination (Join-Path (Join-Path $env:HOME "Downloads") "Kali Linux 2024.3 (64bit).vdi") > $null 2>&1
        }

        Write-Host "[$(Get-Date -Format "dd-MM-yyyy HH:mm:ss")] [2/3] Verwijderen van bestaande virtuele machines en settings..."
        VBoxManage unregistervm $vm_1 --delete > $null 2>&1
        VBoxManage unregistervm $vm_2 --delete > $null 2>&1
        if ($vbxnet_made -eq $true) {
            #VBoxManage hostonlyif remove "$name_vbxnet" > $null 2>&1
            VBoxManage natnetwork remove --netname "NatNetwerkCyberNPE"

        }
        Remove-Item -Path $folder `
            -Recurse `
            -Force > $null 2>&1
        
        Write-Host "[$(Get-Date -Format "dd-MM-yyyy HH:mm:ss")] [3/3] Bestaande virtuele machines en settings zijn verwijderd."
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

$VBXNET_MADE = $false


if ($RES) {

    $PRGM = $($env:PATH -split ";" | ForEach-Object { $_ } | Where-Object { $_ -eq "C:\Program Files\Oracle\VirtualBox" } | Select-Object -First 1)
    if ($PRGM -ne "C:\Program Files\Oracle\VirtualBox") {
        $env:PATH += ";C:\Program Files\Oracle\VirtualBox"
    }

    <#
    $LIST_ONJECTS = $(vboxmanage list hostonlyifs | where-Object { $_ -match "Name:\s+VirtualBox Host-Only Ethernet Adapter\s*" })
    
    if ($LIST_ONJECTS.Count -eq "0") {
        VBoxManage hostonlyif create > $null 2>&1
        VBoxManage hostonlyif ipconfig "VirtualBox Host-Only Ethernet Adapter" --ip 192.168.56.1 `
            --netmask 255.255.255.0 > $null 2>&1
        VBoxManage dhcpserver add --ifname "VirtualBox Host-Only Ethernet Adapter" `
            --ip 192.168.56.2 `
            --netmask 255.255.255.0 `
            --lowerip 192.168.56.3 `
            --upperip 192.168.56.4 `
            --enable > $null 2>&1
    }#>


    
    VBoxManage natnetwork add --netname "NatNetwerkCyberNPE" --network "10.10.10.0/24" --enable > $null 2>&1 # Onderdruk foutmelding, omdat bij verwijderen bestaat het al error
    VBoxManage natnetwork modify --netname "NatNetwerkCyberNPE" --port-forward-4 "ssh:tcp:[]:2222:[10.10.10.2]:22" --port-forward-4 "ssh:tcp:[]:2223:[10.10.10.3]:22" > $null 2>&1 # Onderdruk foutmelding, omdat bij verwijderen bestaat het al error

    <#
    if ($LIST_ONJECTS.Count -eq "1") {
        $VBXNET_MADE = $true
    }#>

    $VBXNET_MADE = $true

    checkVMsExcists -folder $VM_FOLDER `
        -vm_1 $VM_NAAM_1 `
        -vm_2 $VM_NAAM_2 `
        -vbxnet_made $VBXNET_MADE `
        -name_vbxnet "VirtualBox Host-Only Ethernet Adapter" `
        -res $RES
    
}
else {

    $PRGM = $($env:PATH -split ";" | ForEach-Object { $_ } | Where-Object { $_ -eq "/usr/bin/vboxmanage" } | Select-Object -First 1)
    if ($PRGM -ne "/usr/bin/vboxmanage") {
        $env:PATH += ":/usr/bin/vboxmanage"
    }

    $PRGM = $($env:PATH -split ";" | ForEach-Object { $_ } | Where-Object { $_ -eq "/usr/bin/virtualbox" } | Select-Object -First 1)
    if ($PRGM -ne "/usr/bin/virtualbox") {
        $env:PATH += ":/usr/bin/virtualbox"
    }

    <#
    $LIST_ONJECTS = $(vboxmanage list hostonlyifs | where-Object { $_ -match "Name:\s+vboxnet[0-9]" })

    if ($LIST_ONJECTS.Count -eq "0") {
        VBoxManage hostonlyif create > $null 2>&1
        VBoxManage hostonlyif ipconfig "vboxnet0" --ip 192.168.56.1 `
            --netmask 255.255.255.0 > $null 2>&1
        VBoxManage dhcpserver add --ifname "vboxnet0" `
            --ip 192.168.56.2 `
            --netmask 255.255.255.0 `
            --lowerip 192.168.56.3 `
            --upperip 192.168.56.4 `
            --enable > $null 2>&1
    }

    if ($LIST_ONJECTS.Count -eq "1") {
        $VBXNET_MADE = $true
    }#>


    VBoxManage natnetwork add --netname "NatNetwerkCyberNPE" --network "10.10.10.0/24" --enable > $null 2>&1 # Onderdruk foutmelding, omdat bij verwijderen bestaat het al error
    VBoxManage natnetwork modify --netname "NatNetwerkCyberNPE" --port-forward-4 "ssh:tcp:[]:2222:[10.10.10.2]:22" --port-forward-4 "ssh:tcp:[]:2223:[10.10.10.3]:22" > $null 2>&1 # Onderdruk foutmelding, omdat bij verwijderen bestaat het al error


    $VBXNET_MADE = $true


    checkVMsExcists -folder $VM_FOLDER `
        -vm_1 $VM_NAAM_1 `
        -vm_2 $VM_NAAM_2 `
        -vbxnet_made $VBXNET_MADE `
        -name_vbxnet "vboxnet0" `
        -res $RES
}

Write-Host "WARINING:`nDit script maakt gebruik van de VirtualBox command line interface (CLI) 
om virtuele machines aan te maken en configureren. Het script controleert 
of de benodigde VDI-bestanden aanwezig zijn in de opgegeven map 
C:\Users\<Jouw-Gebruikersnaam>\Downloads en maakt vervolgens de virtuele machines 
aan met de juiste instellingen." -ForegroundColor DarkYellow

Pause

Clear-Host

New-Item -Path $VM_FOLDER -ItemType Directory > $null 2>&1

if ($RES) {
    Move-Item -Path (Join-Path (Join-Path $env:USERPROFILE "Downloads") "Ubuntu 24.10 (64bit).vdi") `
        -Destination $VM_FOLDER > $null 2>&1
    Move-Item -Path (Join-Path (Join-Path $env:USERPROFILE "Downloads") "Kali Linux 2024.3 (64bit).vdi") `
        -Destination $VM_FOLDER > $null 2>&1

}
else {
    Move-Item -Path (Join-Path (Join-Path $env:HOME "Downloads") "Ubuntu 24.10 (64bit).vdi") `
        -Destination $VM_FOLDER > $null 2>&1
    Move-Item -Path (Join-Path (Join-Path $env:HOME "Downloads") "Kali Linux 2024.3 (64bit).vdi") `
        -Destination $VM_FOLDER > $null 2>&1
}

$VM_VDI_PAD_1 = Join-Path $VM_FOLDER "Ubuntu 24.10 (64bit).vdi"
$VM_VDI_PAD_2 = Join-Path $VM_FOLDER "Kali Linux 2024.3 (64bit).vdi"

$VM_GEBRUIKERSNAAM_1, $VM_GEBRUIKERSNAAM_2 = "osboxes.org", "osboxes"
$VM_PASSWOORD_1, $VM_PASSWOORD_2 = "osboxes.org", "osboxes.org"

write-Host "De volgende Virtuele Machines worden geinstalleerd en geconfigureerd:
    1. Kwetsbare VM Ubuntu 24.10 (64bit)`n    2. Hacker VM Kali Linux 2024.3 (64bit)"

Start-Sleep -Seconds 3

Clear-Host

Write-Host "VDI's geinstalleerd!" -ForegroundColor Green
Write-Host "[$(Get-Date -Format "dd-MM-yyyy HH:mm:ss")] [1/1] Virtuele machines aanmaken & configureren..."

VBoxManage createvm --name $VM_NAAM_1 `
    --basefolder $VM_FOLDER `
    --groups "/NPE_g" `
    --ostype Ubuntu_64 `
    --register > $null 2>&1

VBoxManage createvm --name $VM_NAAM_2 `
    --basefolder $VM_FOLDER `
    --groups "/NPE_g" `
    --ostype Debian_64 `
    --register > $null 2>&1

if ($RES) {
    <#
    VBoxManage modifyvm $VM_NAAM_1 --memory 2048 `
        --cpus 2 `
        --vram 64 `
        --nic1 hostonly `
        --hostonlyadapter1 "VirtualBox Host-Only Ethernet Adapter" `
        --nic2 nat > $null 2>&1

    VBoxManage modifyvm $VM_NAAM_2 --memory 2048 `
        --cpus 2 `
        --vram 64 `
        --nic1 hostonly `
        --hostonlyadapter1 "VirtualBox Host-Only Ethernet Adapter" `
        --nic2 nat > $null 2>&1
        #>


       VBoxManage modifyvm $VM_NAAM_1 --memory 2048 `
       --cpus 2 `
       --vram 64 `
       --nic1 natnetwork --nat-network1 "NatNetwerkCyberNPE" > $null 2>&1

   VBoxManage modifyvm $VM_NAAM_2 --memory 2048 `
       --cpus 2 `
       --vram 64 `
       --nic1 natnetwork --nat-network1 "NatNetwerkCyberNPE" > $null 2>&1
}
else {
    <#
    VBoxManage modifyvm $VM_NAAM_1 --memory 2048 `
        --cpus 2 `
        --vram 64 `
        --nic1 hostonly `
        --hostonlyadapter1 "vboxnet0" `
        --nic2 nat > $null 2>&1

    VBoxManage modifyvm $VM_NAAM_2 --memory 2048 `
        --cpus 2 `
        --vram 64 `
        --nic1 hostonly `
        --hostonlyadapter1 "vboxnet0" `
        --nic2 nat > $null 2>&1
    #>


    VBoxManage modifyvm $VM_NAAM_1 --memory 2048 `
    --cpus 2 `
    --vram 64 `
    --nic1 natnetwork --nat-network1 "NatNetwerkCyberNPE" > $null 2>&1

VBoxManage modifyvm $VM_NAAM_2 --memory 2048 `
    --cpus 2 `
    --vram 64 `
    --nic1 natnetwork --nat-network1 "NatNetwerkCyberNPE" > $null 2>&1
}

VBoxManage storagectl $VM_NAAM_1 --name "SATA Controller" `
    --add sata `
    --controller IntelAhci > $null 2>&1

VBoxManage storagectl $VM_NAAM_2 --name "SATA Controller" `
    --add sata `
    --controller IntelAhci > $null 2>&1

VBoxManage storageattach $VM_NAAM_1 --storagectl "SATA Controller" `
    --port 0 `
    --device 0 `
    --type hdd `
    --medium $VM_VDI_PAD_1 > $null 2>&1

VBoxManage storageattach $VM_NAAM_2 --storagectl "SATA Controller" `
    --port 0 `
    --device 0 `
    --type hdd `
    --medium $VM_VDI_PAD_2 > $null 2>&1

VBoxManage modifyvm $VM_NAAM_1 --boot1 disk > $null 2>&1
VBoxManage modifyvm $VM_NAAM_2 --boot1 disk > $null 2>&1

VBoxManage snapshot $VM_NAAM_1 take "Init fase" --description "Gebruikersnaam: $VM_GEBRUIKERSNAAM_1 Wachtwoord: $VM_PASSWOORD_1" > $null 2>&1
VBoxManage snapshot $VM_NAAM_2 take "Init fase" --description "Gebruikersnaam: $VM_GEBRUIKERSNAAM_2 Wachtwoord: $VM_PASSWOORD_2" > $null 2>&1

Write-Host "Virtuele machines zijn aangemaakt!" -ForegroundColor Green

VBoxManage startvm $VM_NAAM_1 > $null 2>&1
VBoxManage startvm $VM_NAAM_2 > $null 2>&1

