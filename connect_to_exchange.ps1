Import-PSSession -Verbose (New-PSSession -Verbose -Name Exchange2013 -ConfigurationName Microsoft.Exchange -ConnectionUri http:server-name -Authentication Kerberos) -AllowClobber
