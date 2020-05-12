# comando instala o Hyper-V em todos os computadores listados no arquivo texto HyperVServers.txt e os reinicia uma vez que a role tenha sido instalada.

$computers = Get-Content C:\Users\LocalAdmin\HyperVServers.txt Invoke-Command -ScriptBlock {Add-WindowsFeature Hyper-V -Restart} -ComputerName $computers

# Comandos Abaixo servem para permite que Host Hyper-v seja gerenciado por outro que não está no mesmo dominio ou em Workgroup

# Ver todos os comandos de Powershell para Hyper-v

get-command -module hyper-v 

 
#============ Gerenciar Servidores Hyper-v em Grupo de Trabalho ====
# Rode os comandos no servidor a ser gerenciado
enable-psremoting  
enable-wsmancredssp -Role Server


# Execute os seguintes comandos no computador que vai gerenciar o gerenciador

Set-Item WSMan:\localhost\Client\TrustedHosts -value * -force 
Enable-WSManCredSSP -Role client -DelegateComputer * 

## Em ambos os comando acima você pode trocar o valor * (asterisco) pelo nome FQDN do servidor ou estação de trabalho cliente que gerenciará os servidores.


# Instalar o Hyper-v em um Servidor

Install-WindowsFeature -Name Hyper-V -IncludeAllSubFeature -IncludeManagementTools -Restart

#=================================================================

#Para conectar-se com um sistema operacional convidado, abra uma sessão do PowerShell com privilégios administrativos
#no host Hyper-V e use o cmdlet Enter-PSSession, como no  exemplo a seguir: 

enter-pssession -vmname server1 

# Existem outras maneiras de usar esse recurso. Por exemplo, para executar um único comando do PowerShell na VM, 
# você pode usar o cmdlet Invoke-Command, como nesse exemplo: 

invoke-command -vmname server1 -scriptblock {get-netadapter} 

#=================================================================


### Criação de Maquina Virtual


#Na página Memory, desative Dynamic Memory.  
set-vmmemory -vmname server1 -dynamicmemoryenabled $false 

#Na página Processor, configure Number Of Virtual Processors com 2. 
set-vmprocessor -vmname server1 -count 2  

#Para alterar a alocação de memória com o PowerShell, use o cmdlet Set-VMMemory, como no exemplo a seguir:

set-vmmemory -vmname server1 -startupbytes 1024mb

#Na página Network Adapter/Advanced Features, ative MAC Address Spoofing. 
 
set-vmnetworkadapter -vmname server1 -name “network adapter” -macaddressspoofing  on 

#Criando uma VM no PowerShell  Para criar uma nova máquina virtual com o Windows PowerShell, use o cmdlet New-VM com a  seguinte sintaxe básica: 

new-vm –name virtualmachinename –memorystartupbytes memory -generation <valor>  –newvhdsizebytes disksize  

#Por exemplo, o comando a seguir cria uma nova VM Geração 2 chamada Server1 com  1 GB de memória e uma nova unidade de disco rígido virtual de 40 GB:  

new-vm –name "server1" –generation 2 –memorystartupbytes 1gb –newvhdsizebytes 40gb  

#O cmdlet New-VM tem muitos outros parâmetros, que você pode explorar usando o  cmdlet Get-Help. 



 





