param(
  [Parameter(Mandatory=$true)]
  [string]$Command,
  [string]$Distro = "AlmaLinux-10"
)

$ErrorActionPreference = "Stop"

function Convert-WindowsPathToWsl([string]$p) {
  # D:\A\B -> /mnt/d/A/B
  if ($p -match '^[A-Za-z]:\\') {
    $drive = $p.Substring(0,1).ToLowerInvariant()
    $rest  = $p.Substring(2).Replace('\','/')
    return "/mnt/$drive/$rest"
  }
  return $p
}

# Repo root mapping
$winPath = (Get-Location).Path
$drive = $winPath.Substring(0,1).ToLowerInvariant()
$pathWithoutDrive = $winPath.Substring(2).TrimStart("\").Replace("\","/")
$wslPath = "/mnt/$drive/$pathWithoutDrive"

# Normalize common Windows-ish forms in the command
$cmd = $Command.Trim()

# .\script.sh  -> ./script.sh
$cmd = $cmd -replace '^\.\x5c', './'   # .\ at start
$cmd = $cmd -replace '\x5c', '/'       # remaining backslashes -> slashes

# Convert explicit Windows drive paths inside the command (simple/common case)
# If user passed just a path token like D:\...\setup.sh, convert it.
if ($cmd -match '^[A-Za-z]:/') {
  $cmd = Convert-WindowsPathToWsl $cmd.Replace('/','\')  # reuse converter
}

Write-Host "[INFO] WSL distro: $Distro"
Write-Host "[INFO] WSL path:   $wslPath"
Write-Host "[INFO] Command:    $cmd"

# Pre-run: best-effort dos2unix only if present (ONE LINE to avoid CRLF issues)
$pre = "cd '$wslPath' || exit 2; if command -v dos2unix >/dev/null 2>&1; then echo '[INFO] dos2unix found; normalizing *.sh files (best-effort)...'; find . -type f -name '*.sh' -print0 2>/dev/null | xargs -0 -r dos2unix >/dev/null 2>&1 || true; else echo '[WARN] dos2unix not found in WSL. If scripts contain CRLF (^M), bash may fail. Continuing without normalization.'; fi"

wsl -d $Distro -- bash -lc $pre
wsl -d $Distro -- bash -lc "cd '$wslPath' && $cmd"
exit $LASTEXITCODE