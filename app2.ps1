Add-Type -AssemblyName PresentationFramework
Import-Module C:\temp\ProdSDToolV2\GUI.ps1
#############################################################################################


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
$app_uninstall = $window.FindName("button_uninstall")

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
    $header2.Header = "ID"
    $header3.Header = "Memory"
    $process = Get-Process -ComputerName $cinumber.Text | Sort-Object Name
    $Bindable_Process = $process | Select-Object -Property @{Name='Name';Expression={$_.ProcessName}}, @{Name='ID';Expression={$_.ID}}, @{Name='PM';Expression={$_.PM}}
    $listview_process.ItemsSource = $Process
    }
})
################################ Get Process Event ends
################################ End Process Event starts
$end_task.Add_Click({
    $process_name = $listview_process.SelectedItem.ID
    Write-Host $process_name
    $kill_task = taskkill /F /IM $process_name /T
    $ping_result_show.Text = $kill_task
    Start-Sleep 3.5
    $process = Get-Process | Sort-Object Name
    $Bindable_Process = $process | Select-Object -Property @{Name='Name';Expression={$_.ProcessName}}, @{Name='ID';Expression={$_.ID}}, @{Name='PM';Expression={$_.PM}}
    $listview_process.ItemsSource = $Process

})
################################ End Process Event starts
##################s####################################### Get Installed App Starts

$get_installed_apps.Add_Click({
    $header1.Header = "Application Name"
    $header2.Header = "Vendor"
    $header3.Header = ""
    $installed_apps = Get-Wmiobject -Class Win32_Product -ComputerName $cinumber.Text | select Name, Vendor | sort Name
    $Bindable = $installed_apps | Select-Object -Property @{Name='Name';Expression={$_.Name}}, @{Name='ID';Expression={$_.Vendor}}
    $listview_process.ItemsSource = $Bindable
})

$app_uninstall.Add_Click({

    Write-Host $listview_apps.SelectedItem.ProgramName

})

##################s####################################### Get Installed App Ends
########################################################### Tab 1 Ping Program Ends


########################################################## Tab 2 Active Directory Starts
################################ Variable declaration for form items in Tab 2 starts

$username_lastlogon = $window.FindName("textBox_username")
$lastlogon = $window.FindName("button_lastlogon")
$textbox_result =$window.FindName("textbox_lastlogon")

################################ Variable declaration for form items in Tab 2 ends



$lastlogon.Add_Click({

    $result = Get-ADUser -Identity $username_lastlogon.text -Properties LastLogon -server dcpdc03|   Format-Table UserPrincipalName, @{Name='LastLogon';Expression={[DateTime]::FromFileTime($_.LastLogon)}} | fl | out-string;
    $textbox_result.text = $result

})

########################################################## Tab 2 Active Directory Ends
########################################################## Tab 3 Install MIS Starts
################################ Variable declaration for form items in Tab 3 starts

$open_file = $window.FindName("button_openfile")
$file_name = $window.FindName("textBox_openfile")
$CI_toCopy = $window.FindName("textBox_copyto")
$install_file = $window.FindName("button_install")

################################ Variable declaration for form items in Tab 3 ends


$open_file.Add_Click({
    $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{Multiselect = $true}
    [void]$FileBrowser.ShowDialog()
    $file_name.Text = $FileBrowser.FileNames 

})

$install_file.Add_Click({

    $destination = "\\" + $CI_toCopy.Text + "\C$\temp"
    cmd /c copy /z $file_name.Text $destination

})
########################################################## Tab 3 Install MIS Ends
################################ Variable declaration for form items in Tab 2 starts

$open_file = $window.FindName("button_openfile")
$cinumber_get_apps = $window.FindName("textBox_CI_installed_apps")
$listview_apps = $window.FindName("listView")


################################ Variable declaration for form items in Tab 2 starts



#Get-Process -ComputerName ci0030000 | Sort-Object Name | Format-Table Name, Description

##################Show GUI####################
$window.ShowDialog()