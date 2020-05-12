# Crie uma m�quina virtual com o Windows Server 2016 Datacenter no Hyper-V e fa�a tr�s altera��es antes de lig�-la. 
# A primeira delas � n�o configurar a VM com Dynamic Memory, afinal a mem�ria n�o pode ser flutuante em um host de Hyper-V
# A segunda altera��o � passar as instru��es de virtualiza��o do processador f�sico para a VM com o Comando.

# Listar Vms do Hyper-v

Get-VM

#Passar Instru��o ao Processador
Set-VMProcessor -VMName <Name> -ExposeVirtualizationExtension $true

# E finalmente ajustar a rede para Nested VM que pode ser de duas maneiras:
# Habilitando o MAC address Spoofing ou NAT (Network Address Translation)  
# Para que os pacotes de rede sejam roteados para virtual switch o MAC address spoofing precisa ser ligado atrav�s do comando:

Get-VMNetworkAdapter -VMName <Name> | Set-VMNetworkAdapter -MacAddressSpoofing On

# Docs Microsoft https://docs.microsoft.com/pt-br/azure/virtual-machines/windows/nested-virtualization

# Criando um Adaptador de Rede NAT Para Fornecer Internet as VMS Aninhadas

Start-Process 'https://docs.microsoft.com/pt-br/azure/virtual-machines/windows/nested-virtualization'

# Crie um comutador interno.
New-VMSwitch -Name "InternalNAT" -SwitchType Internal

#Exiba as propriedades do comutador e anote o ifIndex do novo adaptador.
Get-NetAdapter

# InterfaceIndex � ifIndex � o �ndice de interface do comutador virtual criado na etapa anterior

New-NetIPAddress -IPAddress 192.168.0.1 -PrefixLength 24 -InterfaceIndex 11

# No PowerShell, crie uma nova rede NAT.

New-NetNat -Name "InternalNat" -InternalIPInterfaceAddressPrefix 192.168.0.0/24


