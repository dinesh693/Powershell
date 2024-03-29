[xml]$xaml = @"
<Window
  xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
  xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
  Title="MainWindow" Height="623.557" Width="793.309">
    <TabControl x:Name="tabControl" HorizontalAlignment="Left" Height="589" Margin="6,3,0,0" VerticalAlignment="Top" Width="777">
        <TabItem Header="Remote PC">
            <Grid Background="#FFE5E5E5">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="69*"/>
                    <ColumnDefinition Width="188*"/>
                </Grid.ColumnDefinitions>
                <Label x:Name="label" Content="Enter PC Name" HorizontalAlignment="Left" Height="31" Margin="10,6,0,0" VerticalAlignment="Top" Width="140"/>
                <TextBlock x:Name="textBlock1" HorizontalAlignment="Left" Height="292" Margin="13,66,0,0" TextWrapping="WrapWithOverflow" VerticalAlignment="Top" Width="316" Grid.ColumnSpan="2" Background="WhiteSmoke"/>
                <TextBox x:Name="textBox_CInumber" HorizontalAlignment="Left" Height="28" Margin="131,9,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="155" Grid.ColumnSpan="2"/>
                <ListView x:Name="listView_process" HorizontalAlignment="Left" Height="318" Margin="133,71,0,0" VerticalAlignment="Top" Width="423" Grid.Column="1">
                    <ListView.View>
                        <GridView>
                            <GridViewColumn x:Name="header1" Header="" DisplayMemberBinding="{Binding Name}" />
                            <GridViewColumn x:Name="header3" Header="" DisplayMemberBinding="{Binding ID}" />
                        </GridView>
                    </ListView.View>
                </ListView>
                <Canvas Grid.Column="1" HorizontalAlignment="Left" Height="63" Margin="127,3,0,0" VerticalAlignment="Top" Width="430" Background="#FFC5C5C5">
                    <Button x:Name="button_ping" Content="Ping" HorizontalAlignment="Left" Height="22" VerticalAlignment="Top" Width="135" Canvas.Left="3" Canvas.Top="12"/>
                    <Button x:Name="user_logged_on" Content="User Logged In" HorizontalAlignment="Left" Height="21" VerticalAlignment="Top" Width="137" Canvas.Left="142" Canvas.Top="13"/>
                    <Button x:Name="button_get_process" Content="Process" HorizontalAlignment="Left" Height="21" VerticalAlignment="Top" Width="135" Canvas.Left="3" Canvas.Top="34"/>
                    <Button x:Name="button_end_task" Content="End Task" HorizontalAlignment="Left" Height="21" VerticalAlignment="Top" Width="137" Canvas.Left="142" Canvas.Top="34"/>
                    <Button x:Name="button_get_installed_apps" Content="Get Installed Apps" HorizontalAlignment="Left" Height="21" VerticalAlignment="Top" Width="142" Canvas.Left="284" Canvas.Top="13"/>
                    <Button x:Name="button_pc_details" Content="PC Details" HorizontalAlignment="Left" Height="21" VerticalAlignment="Top" Width="142" Canvas.Left="284" Canvas.Top="34"/>
                </Canvas>
                <Canvas Grid.ColumnSpan="2" HorizontalAlignment="Left" Height="73" Margin="13,358,0,0" VerticalAlignment="Top" Width="316" Background="#FFC5BCBC">
                    <Button x:Name="button_flushdns" Content="Flush DNS" Height="25" Canvas.Left="11" Canvas.Top="5" Width="94"/>
                    <Button x:Name="button_displaydns" Content="DNS Details" Height="25" Canvas.Left="11" Canvas.Top="32" Width="94"/>
                </Canvas>
            </Grid>
        </TabItem>
        <TabItem Header="Active Directory">
            <Grid Background="#FFE5E5E5" Margin="10,0,-6,2">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="5*"/>
                    <ColumnDefinition Width="19*"/>
                    <ColumnDefinition Width="54*"/>
                </Grid.ColumnDefinitions>
                <Canvas Grid.ColumnSpan="3" HorizontalAlignment="Left" Height="176" Margin="10,10,0,0" VerticalAlignment="Top" Width="415" Background="#FFB9B9B9">
                    <Label x:Name="label1" Content="Username" HorizontalAlignment="Left" Height="28" VerticalAlignment="Top" Width="68" Canvas.Left="10" Canvas.Top="22"/>
                    <TextBox x:Name="textBox_username" HorizontalAlignment="Left" Height="23" TextWrapping="Wrap" VerticalAlignment="Top" Width="106" Canvas.Left="83" Canvas.Top="27"/>
                    <Button x:Name="button_lastlogon" Content="Last Logon" HorizontalAlignment="Left" Height="28" VerticalAlignment="Top" Width="81" Canvas.Left="194" Canvas.Top="25"/>
                    <TextBlock x:Name="textbox_lastlogon" HorizontalAlignment="Left" Height="117" TextWrapping="Wrap" VerticalAlignment="Top" Width="265" Canvas.Left="10" Canvas.Top="55"/>
                    <Button x:Name="button_memberof" Content="Member Of" HorizontalAlignment="Left" Height="28" VerticalAlignment="Top" Width="81" Canvas.Left="280" Canvas.Top="25"/>
                </Canvas>
                <ListView x:Name="listView_membership" Grid.Column="2" HorizontalAlignment="Left" Height="337" Margin="192,10,0,0" VerticalAlignment="Top" Width="329">
                    <ListView.View>
                        <GridView>
                            <GridViewColumn x:Name="memberof_header1" Header="Member Of" DisplayMemberBinding="{Binding ACLName}" />
                            <GridViewColumn x:Name="memberof_header2" Header="Type" DisplayMemberBinding="{Binding GroupCategory}" />
                        </GridView>
                    </ListView.View>
                </ListView>
                <Canvas Grid.ColumnSpan="3" HorizontalAlignment="Left" Height="156" Margin="10,191,0,0" VerticalAlignment="Top" Width="415" Background="#FFBDBDBD">
                    <Label x:Name="label3" Content="Folder Path" Height="25" Canvas.Left="10" Canvas.Top="22" Width="94"/>
                    <Button x:Name="button" Content="..." Height="29" Canvas.Left="375" Canvas.Top="22" Width="40"/>
                    <Button x:Name="button_lastlogon_Copy2" Content="Check Folder ACL" HorizontalAlignment="Left" Height="28" VerticalAlignment="Top" Width="119" Canvas.Left="87" Canvas.Top="66"/>
                </Canvas>
                <TextBox x:Name="textBox" Grid.ColumnSpan="2" Grid.Column="1" HorizontalAlignment="Left" Height="30" Margin="44,212,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="293"/>
                <Button x:Name="button1" Content="Button" Grid.Column="2" HorizontalAlignment="Left" Margin="852,74,-396,0" VerticalAlignment="Top" Width="75"/>
                <Button x:Name="button_remove_memberof" Content="Remove Access" HorizontalAlignment="Left" Height="28" VerticalAlignment="Top" Width="109" Grid.Column="2" Margin="192,352,0,0"/>
                <Button x:Name="button_remove_distribution" Content="Remove DL Access" HorizontalAlignment="Left" Height="28" VerticalAlignment="Top" Width="109" Grid.Column="2" Margin="192,381,0,0"/>
                <Button x:Name="button_backup" Content="Backup Access" HorizontalAlignment="Left" Height="28" VerticalAlignment="Top" Width="109" Grid.Column="2" Margin="192,410,0,0"/>

            </Grid>
        </TabItem>

    </TabControl>
</Window>
"@
