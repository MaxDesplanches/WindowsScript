<#
			/-----------------------------------------------\
			|       Connexion automatique Résidence    	    |
			|  	    par Max Desplanches			            |
			\-----------------------------------------------/
#>

	# Informations de connexion

	$username	=			"002"
	$password	=			"f7fz"
	$url		=			"http://192.168.0.1:12080/cgi-bin/zscp?Section=CPAuth&Action=Show&ZSCPRedirect=www.google.com:::http://www.google.com/%3f"
	
		
		
	Function	NavigateTo([string] $url, [int] $delayTime = 100)
{
 	$global:ie.Navigate($url) 
 	WaitForPage $delayTime
}
	Function	WaitForPage([int] $delayTime = 100)
{
 	$loaded = $false
  
  		while ($loaded -eq $false) {
    	[System.Threading.Thread]::Sleep($delayTime) 
	
    		if (-not $global:ie.Busy) {
     			$loaded = $true
   			}
  	}
 	 $global:doc = $global:ie.Document
}

	Function	SetElementValueByName($name, $value, [int] $position = 0)
{
  		if ($global:doc -eq $null) {
    		Write-Error "ERREUR: le document est vide."
   			break
 		}
 	$elements = @($global:doc.getElementsByName($name))
	
 		if ($elements.Count -ne 0) {
    		$elements[$position].Value = $value
  		}
  		else {
    	Write-Warning "Element avec le nom ""$name"" est introubable."
  	}
}

Function	ClickElementByName($name, [int] $position = 0)
{
  	if ($global:doc -eq $null) {
    	Write-Error "ERREUR: le document est vide."
    	break
  	}

	$link=$global:doc.getElementsByTagName("input") | where-object {$_.type -eq "button"}
	$link.click()
	WaitForPage 100
}

	# Lancement d'IE

	Write-Host "Lancement d'Internet Explorer en cours ..."
	
	$verbosePreference = "SilentlyContinue"
	$global:ie = New-Object -com "InternetExplorer.Application"
	$global:ie.Navigate("about:blank")
	$global:ie.visible = $false
		if (!($?)) {write-host "ERREUR: Lancement d'Internet Explorer échoué."}

		# Login
	
	Write-Host "Connexion en cours ..."
	
	NavigateTo $url
	SetElementValueByName "U" $username
	SetElementValueByName "P" $password
	ClickElementByName "Network Access"
	
		while ($global:ie.Busy -eq $true){Start-Sleep -Milliseconds 1000;
		}

		if (!($?)) {Write-Error "ERREUR: Login à la page de Mantis impossible."}