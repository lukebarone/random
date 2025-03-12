# Main code adapted from https://renenyffenegger.ch/notes/Windows/PowerShell/examples/WinAPI/modify-mouse-speed

Set-StrictMode -Version Latest
# Ensure coding standards are somewhat maintained

$newSpeed = $(Get-Random -Minimum 1 -Maximum 20)

$winApi = Add-Type -Name user32 -Namespace tq84 -PassThru -MemberDefinition '
   [DllImport("user32.dll")]
    public static extern bool SystemParametersInfo(
       uint uiAction,
       uint uiParam ,
       uint pvParam ,
       uint fWinIni
    );
'

$SPI_SETMOUSESPEED = 0x0071

Write-Output "MouseSensitivity before WinAPI call:  $((Get-ItemProperty 'HKCU:\Control Panel\Mouse').MouseSensitivity)"

$null = $winApi::SystemParametersInfo($SPI_SETMOUSESPEED, 0, $newSpeed, 0)

#
#    Calling SystemParametersInfo() does not permanently store the modification
#    of the mouse speed. It needs to be changed in the registry as well
#
Set-ItemProperty 'HKCU:\Control Panel\Mouse' -Name MouseSensitivity -Value $newSpeed

Write-Output "MouseSensitivity after WinAPI call:  $((Get-ItemProperty 'HKCU:\Control Panel\Mouse').MouseSensitivity)"
