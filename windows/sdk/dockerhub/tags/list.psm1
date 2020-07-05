function Get-Tag([string]$token, [string]$image, [string]$registry = "registry.hub.docker.com") {
  $result = Invoke-WebRequest `
    -Authentication OAuth `
    -Token (ConvertTo-SecureString $token -Force -AsPlainText) `
    "https://$registry/v2/$image/tags/list" `
    -UserAgent "Docker-Client/19.03.5 (Windows)"

  return $result
}

# n=<integer>&last=<integer>

Export-ModuleMember -Function Get-Tag
