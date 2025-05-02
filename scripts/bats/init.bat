@REM Commando's zelf worden niet weergegeven, enkel output
@echo off
setlocal enabledelayedexpansion
set /a getal=1

@REM Systeemmelding
color 0F
call :wait_short
echo De volgende Virtuele Machines worden geinstalleerd en geconfigureerd:
echo.
call :wait_short
echo 1. Kwetsbare VM Ubuntu 24.10 (64bit)
call :wait_short
echo 2. Hacker VM Kali Linux 2024.3 (64bit)
call :wait_long
call :simulatie_functie
call :wait_mid

@REM Lokale variabelen instellen
set VM_NAAM_1=Kwetsbare_Ubuntu_VM
set VM_NAAM_2=Hacker_Kali_VM
set VM_FOLDER=%USERPROFILE%\VirtualBox VMs
set VM_FOLDER_1=%USERPROFILE%\VirtualBox VMs\%VM_NAAM_1%
set VM_FOLDER_2=%USERPROFILE%\VirtualBox VMs\%VM_NAAM_2%
set VM_VDI_PAD_1=%USERPROFILE%\VirtualBox VMs\NPE_OPDRACHT\%VM_NAAM_1%\Ubuntu 24.10 (64bit).vdi
set VM_VDI_PAD_2=%USERPROFILE%\VirtualBox VMs\NPE_OPDRACHT\%VM_NAAM_2%\Kali Linux 2024.3 (64bit).vdi
set VM_GEBRUIKERSNAAM_1=osboxes
set VM_PASSWOORD_1=osboxes.org
set VM_GEBRUIKERSNAAM_2=%VM_GEBRUIKERSNAAM_1%.org
set VM_PASSWOORD_2=%VM_PASSWOORD_1%

@REM Systeemmelding
cls
color 0F
call :wait_short
echo PROGRESS [1/18] Controleren of VirtualBox geinstalleerd is  
call :wait_mid
cd "C:\Program Files\Oracle\VirtualBox" || (
    cls
    call :wait_short
    color OC
    echo Er is een fout opgetreden. Het pad "C:\Program Files\Oracle\VirtualBox" bestaat niet. Mogelijks moet u virtual box eerst installeren.
    call :program_exit
)
call :wait_short
echo PROGRESS [2/18] Creeeren van log bestand  
call :wait_mid
echo # Volgende informatie bevat mogelijke errors die tijdens het proces werden gevonden: > "%USERPROFILE%\Desktop\errors_log.md" || (
    cls
    call :wait_short
    color OC
    echo Er is een fout opgetreden.
    call :program_exit
)
set /a getal=1
cls
call :wait_short
echo Om het script correct te laten verlopen, zorgt u ervoor dat de volgende virtuele harde schijven in de corresponderende locaties staan:
echo.
call :wait_long
echo 1. Versie Ubuntu 24.10 (64bit): "%USERPROFILE%\Downloads\64bit\64bit\Ubuntu 24.10 (64bit).vdi"
call :wait_short
echo 2. Versie Kali Linux 2024.3 (64bit): "%USERPROFILE%\Downloads\64bit (1)\64bit\Kali Linux 2024.3 (64bit).vdi"
echo.
echo U kunt de vdis afhalen via de officiele website: 
call :wait_short
echo https://www.osboxes.org/ubuntu/
echo https://www.osboxes.org/kali-linux/
call :wait_mid
echo ...en uitpakken in de downloads folder.
call :wait_short
echo ...de rest wordt voor u klaargezet.

call :wait_long
call :prompt
call :wait_mid

call :simulatie_functie
set /a getal=1
call :wait_short
cls
echo PROGRESS [3/18] Aanmaken folder voor Ubuntu VM  
call :wait_mid
mkdir "%VM_FOLDER%\NPE_OPDRACHT\%VM_NAAM_1%" >> "%USERPROFILE%\Desktop\errors_log.md" 2>&1  || (
    cls
    color 0C
    call :wait_short
    echo Er is een fout opgetreden bij het aanmaken van de VM folder.
    echo - Er is een fout opgetreden bij het het aanmaken van de VM folder. >> "!USERPROFILE!\Desktop\errors_log.md"
    echo Er is een log bestand die u mogelijks verder kan helpen
    call :wait_short
    notepad "%USERPROFILE%\Desktop\errors_log.md"
    call :wait_short
    cls
    call :program_exit
)

echo PROGRESS [4/18] Aanmaken folder voor Kali VM  
call :wait_mid
mkdir "%VM_FOLDER%\NPE_OPDRACHT\%VM_NAAM_2%" >> "%USERPROFILE%\Desktop\errors_log.md" 2>&1 || (
    cls
    color 0C
    call :wait_short
    echo Er is een fout opgetreden bij het aanmaken van de VM folder. 
    echo - Er is een fout opgetreden bij het het aanmaken van de VM folder. >> "!USERPROFILE!\Desktop\errors_log.md"
    echo Er is een log bestand die u mogelijks verder kan helpen
    call :wait_short
    notepad "!USERPROFILE!\Desktop\errors_log.md"
    call :wait_short
    cls
    call :program_exit
)

echo PROGRESS [5/18] VDI Ubuntu VM verplaatsen van downloads folder naar bestemmingsfolder  
call :wait_mid
copy "%USERPROFILE%\Downloads\64bit\64bit\Ubuntu 24.10 (64bit).vdi" "%VM_FOLDER%\NPE_OPDRACHT\%VM_NAAM_1%" >> "%USERPROFILE%\Desktop\errors_log.md" 2>&1 || (
    cls
    color 0C
    call :wait_short
    echo Er is een fout opgetreden bij het verplaatsen van de ubuntu vdi bestand.
    echo - Er is een fout opgetreden bij het verplaatsen van de ubuntu vdi bestand >> "!USERPROFILE!\Desktop\errors_log.md"
    echo Er is een log bestand die u mogelijks verder kan helpen
    call :wait_short
    notepad "!USERPROFILE!\Desktop\errors_log.md"
    call :wait_short
    cls
    call :program_exit
)
@REM copy moet move zijn
echo PROGRESS [6/18] VDI Kali VM verplaatsen van downloads folder naar bestemmingsfolder  
call :wait_mid
copy "%USERPROFILE%\Downloads\64bit (1)\64bit\Kali Linux 2024.3 (64bit).vdi" "%VM_FOLDER%\NPE_OPDRACHT\%VM_NAAM_2%" >> "%USERPROFILE%\Desktop\errors_log.md" 2>&1 || (
    cls
    color 0C
    call :wait_short    
    echo Er is een fout opgetreden bij het verplaatsen van de kali vdi bestand
    echo - Er is een fout opgetreden bij het verplaatsen van de kali vdi bestand >> "!USERPROFILE!\Desktop\errors_log.md"
    echo Er is een log bestand die u mogelijks verder kan helpen
    call :wait_short    
    notepad "!USERPROFILE!\Desktop\errors_log.md"
    color 0F
    cls
    call :program_exit
)

@REM VMs creeeren
echo PROGRESS [7/18] Ubuntu VM wordt nu aangemaakt  
call :wait_mid
VBoxManage.exe createvm --name %VM_NAAM_1% ^
--basefolder "%VM_FOLDER%" ^
--groups "/NPE_Opdracht" ^
--ostype "Ubuntu_64" ^
--register >> "%USERPROFILE%\Desktop\errors_log.md" 2>&1 || (
    cls
    color 0C
    call :wait_short    
    echo Er is een fout opgetreden bij het creeeren van de %VM_NAAM_1%
    echo - Er is een fout opgetreden bij het creeeren van de %VM_NAAM_1% >> "!USERPROFILE!\Desktop\errors_log.md"
    echo Er is een log bestand die u mogelijks verder kan helpen
    call :wait_short    
    notepad "!USERPROFILE!\Desktop\errors_log.md"
    cls
    color 0F
    call :program_exit
)

echo PROGRESS [8/18] Kali VM wordt nu aangemaakt  
call :wait_mid
VBoxManage.exe createvm --name %VM_NAAM_2% ^
--basefolder "%VM_FOLDER%" ^
--groups "/NPE_Opdracht" ^
--ostype "Debian_64" ^
--register >> "%USERPROFILE%\Desktop\errors_log.md" 2>&1 || (
    cls
    color 0C
    call :wait_short
    echo Er is een fout opgetreden bij het creeeren van de %VM_NAAM_2%
    echo - Er is een fout opgetreden bij het creeeren van de %VM_NAAM_2% >> "!USERPROFILE!\Desktop\errors_log.md"
    echo Er is een log bestand die u mogelijks verder kan helpen
    call :wait_short    
    notepad "!USERPROFILE!\Desktop\errors_log.md"    
    cls
    color 0F
    call :program_exit
)

@REM VMs configureren
echo PROGRESS [9/18] Ubuntu VM wordt nu geconfigureerd  
call :wait_mid
VBoxManage.exe modifyvm %VM_NAAM_1% --memory 2048 ^
--cpus 2 ^
--vram 16 ^
--nic1 intnet >> "%USERPROFILE%\Desktop\errors_log.md" 2>&1 || (
    cls
    color 0C
    call :wait_short    
    echo Er is een fout opgetreden bij het configureren van de %VM_NAAM_1%, meer bepaald het alloceren van de memory, cores, vram en nic.
    echo - Er is een fout opgetreden bij het configureren van de %VM_NAAM_1%, meer bepaald het alloceren van de memory, cores, vram en nic. >> "!USERPROFILE!\Desktop\errors_log.md"
    echo Er is een log bestand die u mogelijks verder kan helpen
    call :wait_short    
    notepad "!USERPROFILE!\Desktop\errors_log.md" 
    cls    
    color 0F
    call :program_exit
)

echo PROGRESS [10/18] Kali VM wordt nu geconfigureerd  
call :wait_mid
VBoxManage.exe modifyvm %VM_NAAM_2% --memory 2048 ^
--cpus 2 ^
--vram 16 ^
--nic1 intnet >> "%USERPROFILE%\Desktop\errors_log.md" 2>&1 || (
    cls
    color 0C
    call :wait_short    
    echo Er is een fout opgetreden bij het configureren van de %VM_NAAM_2%, meer bepaald het alloceren van de memory, cores, vram en nic.
    echo - Er is een fout opgetreden bij het configureren van de %VM_NAAM_2%, meer bepaald het alloceren van de memory, cores, vram en nic. >> "!USERPROFILE!\Desktop\errors_log.md"
    echo Er is een log bestand die u mogelijks verder kan helpen
    call :wait_short    
    notepad "!USERPROFILE!\Desktop\errors_log.md"    
    cls
    color 0F
    call :program_exit
)

echo PROGRESS [11/18] Ubuntu VM wordt nu verder geconfigureerd  
call :wait_mid
VBoxManage.exe storagectl %VM_NAAM_1% --name "SATA Controller" ^
--add sata ^
--controller IntelAhci >> "%USERPROFILE%\Desktop\errors_log.md" 2>&1 || (
    cls
    color 0C
    call :wait_short    
    echo Er is een fout opgetreden bij het configureren van de %VM_NAAM_1%, meer bepaald de sata controller.
    echo - Er is een fout opgetreden bij het configureren van de %VM_NAAM_1%, meer bepaald de sata controller. >> "!USERPROFILE!\Desktop\errors_log.md"
    echo Er is een log bestand die u mogelijks verder kan helpen
    call :wait_short    
    notepad "!USERPROFILE!\Desktop\errors_log.md"   
    cls
    call :program_exit
)

echo PROGRESS [12/18] Kali VM wordt nu verder geconfigureerd  
call :wait_mid
VBoxManage.exe storagectl %VM_NAAM_2% --name "SATA Controller" ^
--add sata ^
--controller IntelAhci >> "%USERPROFILE%\Desktop\errors_log.md" 2>&1 || (
    cls
    color 0C
    call :wait_short
    echo Er is een fout opgetreden bij het configureren van de %VM_NAAM_2%, meer bepaald de sata controller.
    echo - Er is een fout opgetreden bij het configureren van de %VM_NAAM_2%, meer bepaald de sata controller. >> "!USERPROFILE!\Desktop\errors_log.md"
    echo Er is een log bestand die u mogelijks verder kan helpen
    call :wait_short    
    notepad "!USERPROFILE!\Desktop\errors_log.md"    
    cls
    call :program_exit
)

echo PROGRESS [13/18] SATA controller wordt gekoppeld aan Ubuntu VM
call :wait_mid
VBoxManage.exe storageattach %VM_NAAM_1% --storagectl "SATA Controller" ^
--port 0 ^
--device 0 ^
--type hdd ^
--medium "%VM_VDI_PAD_1%" >> "%USERPROFILE%\Desktop\errors_log.md" 2>&1 || (
    cls
    color 0C
    call :wait_short
    echo Er is een fout opgetreden bij het toevoegen van de %VM_NAAM_1% vdi aan de sata controller. Mogelijks heeft u twee dezelfde vdi's staan. Er wordt geprobeerd dit voor je op te lossen.  
    @REM Oplossen problemen
    @REM ------------------
    echo [EXTRA] Ubuntu VM vdi UUID wordt aangepast  
    call :wait_mid
    VBoxManage closemedium disk "!VM_VDI_PAD_1!" >> "!USERPROFILE!\Desktop\errors_log.md" 2>&1 || (
        cls
        color 0C
        call :wait_short
        echo Er is een fout opgetreden bij het loskoppelen van de vdi aan !VM_NAAM_1!.
        echo - Er is een fout opgetreden bij het loskoppelen van de vdi aan !VM_NAAM_1! >> "!USERPROFILE!\Desktop\errors_log.md"
        echo Er is een log bestand die u mogelijks verder kan helpen   
        call :wait_short    
        notepad "!USERPROFILE!\Desktop\errors_log.md" 
        cls
        call :program_exit
    )
    VBoxManage.exe internalcommands sethduuid "!VM_VDI_PAD_1!" >> "!USERPROFILE!\Desktop\errors_log.md" 2>&1 || (
        cls
        color 0C
        call :wait_short
        echo Er is een fout opgetreden bij het veranderen van de UUID van de !VM_NAAM_1!.
        echo - Er is een fout opgetreden bij het veranderen van de UUID van de !VM_NAAM_1! >> "!USERPROFILE!\Desktop\errors_log.md"
        echo Er is een log bestand die u mogelijks verder kan helpen   
        call :wait_short    
        notepad "!USERPROFILE!\Desktop\errors_log.md" 
        cls
        call :program_exit
    )
    @REM ------------------
    echo - Er is een fout opgetreden bij het toevoegen van de !VM_NAAM_1! vdi aan de sata controller. Mogelijks heeft u twee dezelfde vdi's staan. Er wordt geprobeerd dit voor je op te lossen. >> "%USERPROFILE%\Desktop\errors_log.md"
    echo Er is een log bestand die u mogelijks verder kan helpen
    call :wait_short    
    notepad "!USERPROFILE!\Desktop\errors_log.md"       
    cls
    call :program_exit
)


echo PROGRESS [14/18] SATA controller wordt gekoppeld aan Kali VM
call :wait_mid
VBoxManage.exe storageattach %VM_NAAM_2% --storagectl "SATA Controller" ^
--port 0 ^
--device 0 ^
--type hdd ^
--medium "%VM_VDI_PAD_2%" >> "%USERPROFILE%\Desktop\errors_log.md" 2>&1 || (
    cls
    color 0C
    call :wait_short
    echo Er is een fout opgetreden bij het toevoegen van de !VM_NAAM_2! vdi aan de sata controller. Mogelijks heeft u twee dezelfde vdi's staan. Er wordt geprobeerd dit voor je op te lossen.  
    @REM Oplossen problemen
    @REM ------------------
    echo [EXTRA] Kali VM vdi UUID wordt aangepast  
    call :wait_mid
    VBoxManage closemedium disk "!VM_VDI_PAD_2!" >> "!USERPROFILE!\Desktop\errors_log.md" 2>&1 || (
        cls
        color 0C
        call :wait_short
        echo Er is een fout opgetreden bij het loskoppelen van de vdi aan !VM_NAAM_2!.
        echo - Er is een fout opgetreden bij het loskoppelen van de vdi aan !VM_NAAM_2! >> "!USERPROFILE!\Desktop\errors_log.md"
        echo Er is een log bestand die u mogelijks verder kan helpen   
        call :wait_short    
        notepad "!USERPROFILE!\Desktop\errors_log.md" 
        cls
        call :program_exit
    )
    VBoxManage.exe internalcommands sethduuid "!VM_VDI_PAD_2!" >> "!USERPROFILE!\Desktop\errors_log.md" 2>&1 || (
        cls
        color 0C
        call :wait_short
        echo Er is een fout opgetreden bij het veranderen van de UUID van de !VM_NAAM_2!.
        echo - Er is een fout opgetreden bij het veranderen van de UUID van de !VM_NAAM_2! >> "!USERPROFILE!\Desktop\errors_log.md"
        echo Er is een log bestand die u mogelijks verder kan helpen   
        call :wait_short    
        notepad "!USERPROFILE!\Desktop\errors_log.md" 
        cls
        call :program_exit
    )
    @REM ------------------
    echo - Er is een fout opgetreden bij het toevoegen van de !VM_NAAM_2! vdi aan de sata controller. Mogelijks heeft u twee dezelfde vdi's staan. Er wordt geprobeerd dit voor je op te lossen. >> "%USERPROFILE%\Desktop\errors_log.md"
    echo Er is een log bestand die u mogelijks verder kan helpen   
    call :wait_short    
    notepad "!USERPROFILE!\Desktop\errors_log.md" 
    cls
    call :program_exit
)

echo PROGRESS [15/18] Boot order wordt vastgelegd voor de Ubuntu VM
call :wait_mid
VBoxManage.exe modifyvm %VM_NAAM_1% --boot1 disk >> "%USERPROFILE%\Desktop\errors_log.md" 2>&1 || (
    cls
    color 0C
    call :wait_short
    echo Er is een fout opgetreden bij het bepalen van boot orde van !VM_NAAM_1!.
    echo - Er is een fout opgetreden bij het bepalen van boot orde van !VM_NAAM_1!. >> "!USERPROFILE!\Desktop\errors_log.md"
    echo Er is een log bestand die u mogelijks verder kan helpen   
    call :wait_short    
    notepad "!USERPROFILE!\Desktop\errors_log.md"    
    cls
    call :program_exit
)

echo PROGRESS [16/18] Boot order wordt vastgelegd voor de Kali VM
call :wait_mid
VBoxManage.exe modifyvm %VM_NAAM_2% --boot1 disk >> "%USERPROFILE%\Desktop\errors_log.md" 2>&1 || (
    cls
    color 0C
    call :wait_short
    echo Er is een fout opgetreden bij het bepalen van boot orde van !VM_NAAM_2!.
    echo - Er is een fout opgetreden bij het bepalen van boot orde van !VM_NAAM_2!. >> "!USERPROFILE!\Desktop\errors_log.md"
    echo Er is een log bestand die u mogelijks verder kan helpen   
    call :wait_short    
    notepad "!USERPROFILE!\Desktop\errors_log.md" 
    cls
    call :program_exit
)

cls
color 0A
echo Installaties en configuraties gelukt!
call :wait_short
cls
echo.
color 0F

echo PROGRESS [17/18] Backup worden nu gemaakt voor Ubuntu VM
call :wait_mid

@REM Als alles tot nu toe gelukt is, dan worden er snapshots gecreeerd.
VBoxManage snapshot "%VM_NAAM_1%" take "Init fase" --description "Gebruikersnaam: %VM_GEBRUIKERSNAAM_1%, Wachtwoord: %VM_PASSWOORD_1%" >> "%USERPROFILE%\Desktop\errors_log.md" 2>&1 || (
    cls
    color 0C
    call :wait_short
    echo Er is een fout opgetreden bij het maken van een back-up voor !VM_NAAM_1!.
    echo - Er is een fout opgetreden bij het maken van een back-up voor !VM_NAAM_1!. >> "!USERPROFILE!\Desktop\errors_log.md"
    echo Er is een log bestand die u mogelijks verder kan helpen   
    call :wait_short    
    notepad "!USERPROFILE!\Desktop\errors_log.md" 
    cls
    call :program_exit
)

echo PROGRESS [18/18] Backup worden nu gemaakt voor Kali VM
call :wait_mid
VBoxManage snapshot "%VM_NAAM_2%" take "Init fase" --description "Gebruikersnaam: %VM_GEBRUIKERSNAAM_2%, Wachtwoord: %VM_PASSWOORD_2%" >> "%USERPROFILE%\Desktop\errors_log.md" 2>&1 || (
    cls
    color 0C
    call :wait_short
    echo Er is een fout opgetreden bij het maken van een back-up voor !VM_NAAM_2!.
    echo - Er is een fout opgetreden bij het maken van een back-up voor !VM_NAAM_2!. >> "!USERPROFILE!\Desktop\errors_log.md"
    echo Er is een log bestand die u mogelijks verder kan helpen   
    call :wait_short    
    notepad "!USERPROFILE!\Desktop\errors_log.md" 
    cls
    call :program_exit
)
color 0F

echo.
cls
color 0A
echo Setup is klaar.
call :wait_short
cls
color 0F
echo VMs starten...

VBoxManage.exe startvm %VM_NAAM_1% >> "%USERPROFILE%\Desktop\errors_log.md" 2>&1 || (
    cls
    color 0C
    call :wait_short
    echo Er is een fout opgetreden bij het opstarten van !VM_NAAM_1!. Probeer handmatig op te starten.
    echo - Er is een fout opgetreden bij het opstarten van !VM_NAAM_1!. Probeer handmatig op te starten. >> "!USERPROFILE!\Desktop\errors_log.md"
    echo Er is een log bestand die u mogelijks verder kan helpen   
    call :wait_short    
    notepad "!USERPROFILE!\Desktop\errors_log.md"
    cls
    call :program_exit
)
VBoxManage.exe startvm %VM_NAAM_2% >> "%USERPROFILE%\Desktop\errors_log.md" 2>&1 || (
    cls
    color 0C
    call :wait_short
    echo Er is een fout opgetreden bij het opstarten van !VM_NAAM_2!.
    echo - Er is een fout opgetreden bij het opstarten van !VM_NAAM_2!. >> "!USERPROFILE!\Desktop\errors_log.md"
    echo Er is een log bestand die u mogelijks verder kan helpen   
    call :wait_short    
    notepad "!USERPROFILE!\Desktop\errors_log.md"
    cls
    call :program_exit
)

@REM Gebruiksvriendelijke functies toepassing

:simulatie_functie
if %getal% lss 4 (
    set simulatie=.
    echo|set /p=%simulatie% 
    set /a getal=%getal% + 1
    timeout /t 1 /nobreak > nul 2>&1
    goto simulatie_functie
)

goto :eof

:prompt
echo.
set /p antwoord=Ga verder? (J/N):
if /i "%antwoord%" == "j" (
    call :wait_short
    cls
) else (
    if /i "%antwoord%" == "ja" (
        call :wait_short
        cls
    ) else (
         exit 0
    )
)
goto :eof

:wait_short
timeout /t 2 /nobreak > nul 2>&1
goto :eof

:wait_mid
timeout /t 3 /nobreak > nul 2>&1
goto :eof

:wait_long
timeout /t 4 /nobreak > nul 2>&1
goto :eof

:program_exit
color 0F
call :wait_short
call :default
echo Afsluiten
call :simulatie_functie
 exit 1

:default
echo.
echo Alle wijzigingen worden ongedaan gemaakt...
rmdir /s /q "%VM_FOLDER%\NPE_OPDRACHT"
del "%USERPROFILE%\Desktop\errors_log.md"
vboxmanage unregistervm "%VM_NAAM_1%" --delete > nul 2>&1 || (
    cls
    color 0C
    call :wait_short
    echo Er is een fout opgetreden bij het ongedaan maken van !VM_NAAM_1!. U moet deze handmatig verwijderen in Oracle Virtual Box en in de map !VM_FOLDER_1!
    call :wait_short
    cls
    color 0F
    echo Afsluiten
    call :simulatie_functie
    set /a getal=1
    call :wait_short
    call :wait_mid
     exit 1
)
vboxmanage unregistervm "%VM_NAAM_2%" --delete > nul 2>&1 || (
    cls
    color 0C
    call :wait_short
    echo Er is een fout opgetreden bij het ongedaan maken van !VM_NAAM_2!. U moet deze handmatig verwijderen in Oracle Virtual Box en in de map !VM_FOLDER_2!
    call :wait_short
    cls
    color 0F
    echo Afsluiten
    call :simulatie_functie
    set /a getal=1
    call :wait_short
    call :wait_mid
     exit 1
)
goto :eof