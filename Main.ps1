Add-Type -AssemblyName PresentationFramework
Import-Module .\GUI.ps1
#############################################################################################
$esc = [char]27
$nl = [Environment]::NewLine
$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)



########################################################### Tab 1 Ping Program Start
################################ Variable declaration for form items on Tab1 start

$ping_result_show = $window.FindName("textBlock1")
$pingButton = $window.FindName("button_ping")
$cinumber = $window.FindName("textBox_CInumber")
$user_logged_on = $window.FindName("user_logged_on")
$get_process = $window.FindName("button_get_process")
$listview_process = $window.FindName("listView_process")
$end_task = $window.FindName("button_end_task")
$header1 = $window.FindName("header1")
$header2 = $window.FindName("header2")
$header3 = $window.FindName("header3")
$cinumber.Text = "CI00"
$get_installed_apps = $window.FindName("button_get_installed_apps")
$button_pc_details = $window.FindName("button_pc_details")

################################ Variable declaration for form items on Tab1 Ends


################################ Ping Click Event starts
$pingButton.Add_Click({
    if($cinumber.Text -eq ''){
        $ping_result_show.Text = "Enter CI number of PC."
    }
    else{
    $ping_result = ping $cinumber.text | fl | out-string;
    $ping_result_show.Text = $ping_result
    }

})
################################ Ping Click Event Ends
################################ User Logged In Click Event starts
$user_logged_on.Add_Click({
    if($cinumber.Text -eq ''){
        $ping_result_show.Text = "Enter CI number of PC."
    }
    else{
    $username = Get-WmiObject -Class Win32_computersystem -ComputerName $cinumber.Text | Select-Object -ExpandProperty Username 
    $ping_result_show.Text = $username
    }
})
################################ User Logged In Click Event Ends
################################ Get Process Event starts
$get_process.Add_Click({
    if($cinumber.Text -eq ''){
        $ping_result_show.Text = "Enter CI number of PC."
    }
    else{
    $header1.Header = "Process Name"
    $header3.Header = "ID"
    
    $process = Get-WmiObject -Class Win32_Process -ComputerName $cinumber.Text -ErrorVariable get_process_error | Sort-Object Name 
    $Bindable_Process = $process | Select-Object -Property @{Name='Name';Expression={$_.ProcessName}}, @{Name='ID';Expression={$_.ProcessID}}
    $listview_process.ItemsSource = $Bindable_Process
    if($get_process_error){ $ping_result_show.Text = $get_process_error} #"Unable to retrieve process from " +  $cinumber.Text + ". Check PC is online or is not local PC"}
    }
    
})
################################ Get Process Event ends
################################ End Process Event starts
$end_task.Add_Click(
{
    $process_selected = $listview_process.SelectedItem.Name
    write-host $process_selected

    Try {
        $returnval = (Get-WmiObject -Class Win32_Process -ComputerName $cinumber.Text | ?{ $_.name -eq $process_selected } | %{ $_.Terminate() })
    } Catch 
    {
        Write-Warning "Failed to end the process. Review the error message"
        Write-Warning $_.Exception.Message
        exit
    }

    Start-Sleep 3.5
    $process = Get-WmiObject -Class Win32_Process -ComputerName $cinumber.Text -ErrorVariable get_process_error | Sort-Object Name 
    $Bindable_Process = $process | Select-Object -Property @{Name='Name';Expression={$_.ProcessName}}, @{Name='ID';Expression={$_.ProcessID}}
    $listview_process.ItemsSource = $Bindable_Process

})
################################ End Process Event starts
##################s####################################### Get Installed App Starts

$get_installed_apps.Add_Click({
    $header1.Header = "Application Name"
    $header3.Header = "Vendor"
    $installed_apps = Get-Wmiobject -Class Win32_Product -ComputerName $cinumber.Text | select Name, Vendor | sort Name
    $Bindable = $installed_apps | Select-Object -Property @{Name='Name';Expression={$_.Name}}, @{Name='ID';Expression={$_.Vendor}}
    $listview_process.ItemsSource = $Bindable
})

$button_pc_details.Add_Click({

   $ping_result_show.Text
   $caption = Get-WmiObject -class Win32_OperatingSystem -ComputerName $cinumber.Text| Select-Object  Caption | ForEach{ $_.Caption }
   $servicepack = Get-WmiObject -class Win32_OperatingSystem -ComputerName $cinumber.Text| Select-Object  ServicePackMajorVersion | ForEach{ $_.ServicePackMajorVersion }
   $osarch = Get-WmiObject -class Win32_OperatingSystem -ComputerName $cinumber.Text| Select-Object  OSArchitecture | ForEach{ $_.OSArchitecture }
   $build_number = Get-WmiObject -class Win32_OperatingSystem -ComputerName $cinumber.Text| Select-Object  BuildNumber | ForEach{ $_.BuildNumber }
   $host_name = Get-WmiObject -class Win32_OperatingSystem -ComputerName $cinumber.Text| Select-Object  CSName | ForEach{ $_.CSName }
   $disk = Get-WmiObject -Class Win32_logicaldisk -ComputerName $cinumber.Text -Filter "DriveType = '3'" | Select-Object -Property DeviceID, DriveType, VolumeName, @{L='FreeSpaceGB';E={"{0:N2}" -f ($_.FreeSpace /1GB)}},@{L="Capacity";E={"{0:N2}" -f ($_.Size/1GB)}} | fl | Out-String
   $ping_result_show.Text = "OS Version: $caption " + $nl + "Service Pack Version: $servicepack " + $nl + "OS Architecture: $osarch " + $nl + "Build Number: $build_number"  + $nl + "Host Name: $host_name " + $nl + $nl + "$esc Disk Info: $disk"
})
 
##################s####################################### Get Installed App Ends
########################################################### Tab 1 Ping Program Ends


########################################################## Tab 2 Active Directory Starts
################################ Variable declaration for form items in Tab 2 starts

$username_lastlogon = $window.FindName("textBox_username")
$lastlogon = $window.FindName("button_lastlogon")
$textbox_result =$window.FindName("textbox_lastlogon")
$button_memberof =$window.FindName("button_memberof")
$listview_memberof = $window.FindName("listView_membership")
$memberof_header1 = $window.FindName("memberof_header1")
$memberof_header2 = $window.FindName("memberof_header2")


################################ Variable declaration for form items in Tab 2 ends
##################s####################################### Get User Last logon start
$lastlogon.Add_Click({

    $result = Get-ADUser -Identity $username_lastlogon.text -Properties LastLogon -server dcpdc03|   Format-Table UserPrincipalName, @{Name='LastLogon';Expression={[DateTime]::FromFileTime($_.LastLogon)}} | fl | out-string;
    $textbox_result.text = $result

})
##################s####################################### Get User Last logon Ends
##################s####################################### Get User Membership start

$button_memberof.Add_Click({
    $member_of = Get-ADPrincipalGroupMembership -Identity $username_lastlogon.text | Select-Object -ExpandProperty Name
    $memberof_header1.Header = "ACL Name"
    $Bindable_memberof = $member_of | Select-Object -Property @{Name='ACLName';Expression={$_.Name}} <#, @{Name='Description';Expression={$_.Vendor} }   #>
    $listview_memberof.ItemsSource = $Bindable_memberof
})

##################s####################################### Get User Membership Ends
########################################################## Tab 2 Active Directory Ends
########################################################## Tab 3 Install MIS Starts

$window.ShowDialog()
