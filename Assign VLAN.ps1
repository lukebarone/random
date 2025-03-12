# Add VLAN to NIC

[int]$vlanID = Read-Host -Prompt "VLAN to join (0 to set to Access):"
$adapterList = Get-NetAdapter -Name * -Physical
$menu = @{}
for ($i = 1; $i -le $adapterList.count; $i++) {
	Write-Host "$i. $($adapterList[$i-1].Name)"
	$menu.Add($i,($adapterList[$i-1].Name))
}
[int]$adapter = Read-Host -Prompt "Which adapter:"
Set-NetAdapter -Name "$($adapterList[$adapter-1].Name)" -VlanID $vlanID -Confirm:$false