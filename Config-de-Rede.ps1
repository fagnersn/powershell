# use estes comandos para configurar a rede e inserir o servidor ao domínio do Active Directory.

# Saber Qual são os dados das interfaces de Rede Presente na Maquina 

Get-NetIPAddress -AddressFamily IPv4 | select InterfaceAlias, IPAddress,InterfaceIndex | More

# Inserir Endereço IP

New-NetIPAddress -interfacealias ethernet0 -IPAddress 192.168.3.200 -Prefixlength 24 -defaultgateway 192.168.3.2

# Inserir Servidor DNS

Set-DNSClientServerAddress -interfacealias ethernet0 -ServerAddress 192.168.3.10

# Liberar Conexões de Entrada do Firewall

New-NetFirewallRule -displayname "Allow All Traffic" -direction outbound -action allow 
New-NetFirewallRule -displayname "Allow All Traffic" -direction inbound -action allow

# Adicionar Computador ao Dominio

Add-Computer -newname HYPERV01 -domainname banin.com -restart




