if(!(Test-Path Variable:HOME)){
  $HOME = [Environment]::GetEnvironmentVariable('HOME')
}

if(!(Test-Path Variable:ProgramFiles)){
  $ProgramFiles = [Environment]::GetEnvironmentVariable('ProgramFiles')
}

if(!(Test-Path Variable:SystemDrive)){
  $SystemDrive = [Environment]::GetEnvironmentVariable('SystemDrive')
}

Class App {
  [string]$name
  [string[]]$paths

  App([string]$name, [string[]]$paths) {
    $this.name = $name
    $this.paths = $paths
  }
}

$appList = [App[]](
  [App]::new("vim", @($ProgramFiles + "\vim80-kaoriya-win64")),
  [App]::new("ConEmu", @($ProgramFiles + "\ConEmu")),
  [App]::new("git", @($ProgramFiles + "\Git\cmd")),
  [App]::new("msys", @($SystemDrive + "\msys64", $SystemDrive + "\msys64\usr\bin")),
  [App]::new("docker", @($ProgramFiles + "\Docker Toolbox")),
  [App]::new("dotfiles", @($HOME + "\dotfiles\bin"))
)
