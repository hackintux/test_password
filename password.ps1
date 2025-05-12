param (
    [Parameter(Mandatory=$true)]
    [string]$Username
)

# Liste de mots de passe à tester
$passwordsToTry = @(
    "Admin123!",
    "Technicien2024",
    "Password!",
    "azerty123",
    "ClicOnLine#2023"
)

function Test-Credentials {
    param (
        [string]$User,
        [string]$Password
    )

    $secPassword = ConvertTo-SecureString $Password -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential($User, $secPassword)

    try {
        $null = Start-Process -FilePath "cmd.exe" -Credential $cred -ArgumentList "/c exit" -ErrorAction Stop -WindowStyle Hidden
        return $true
    } catch {
        return $false
    }
}

Write-Output "🔍 Test des mots de passe pour l'utilisateur local : $Username"

foreach ($pwd in $passwordsToTry) {
    Write-Output " - Test : $pwd"
    if (Test-Credentials -User $Username -Password $pwd) {
        Write-Output "✅ Mot de passe valide trouvé : $pwd"
        exit 0
    }
}

Write-Output "❌ Aucun mot de passe valide trouvé."
exit 1
