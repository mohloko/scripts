@echo off

#montando os compartilhamentos
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2\##zeus#%username% /v _LabelFromReg /t REG_SZ /f /d "BACKUP"
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2\##zeus#%username%#Scanner /v _LabelFromReg /t REG_SZ /f /d "SCANNER"
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2\##zeus#Publico /v _LabelFromReg /t REG_SZ /f /d "PASTA PUBLICA"

net use y: \\zeus\%username% /yes
net use z: \\zeus\%username%\Scanner /yes
net use g: \\zeus\Publico /yes

#setando a hora
net time \\zeus /set /yes
