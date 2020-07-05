# 地址 地址+端口 | 用户名 无用户名 | 镜像 | 标签 无标签

# docker.io docker.io:9000 library - golang latest -

# 12 - 4 = 8

# $env:SOURCE_DOCKER_REGISTRY =
# $env:DEST_DOCKER_REGISTRY = "default.dest.ccs.tencentyun.com"

# $env:SOURCE_NAMESPACE = "library"
# $env:DEST_NAMESPACE = "library"

Function imageParser([string] $config, [boolean] $source = $true) {
  $config, $digest = $config.split('@')

  # host:port/user/image:ref
  # host:port/image:ref -
  if ($config.split(':').count -eq 3) {
    $_registry, $port_plus_image, $ref = $config.split(':')
    $image = "${_registry}:${port_plus_image}"
  }
  # host:port/user/image
  # host:port/image -
  # user/image:ref          user/x/y/z/image:ref
  # host/image:ref -
  # host/user/image:ref
  # image:ref               x/y/z/image:ref
  elseif ($config.split(':').count -eq 2) {
    if (!($config.contains('/'))) {
      # image:ref
      $image, $ref = $config.split(':')
    }
    else {
      $image, $ref = $config.split(':')
      if ($image.contains('/')) {
        # host/user/image:ref
        # user/image:ref
      }
      else {
        # host:port/user/image
        $_registry, $port_plus_image = $config.split(':')
        $port, $image = $port_plus_image.split('/', 2)
        $registry = "${_registry}:${port}"
        $ref = $null
      }
    }
  }
  # image               x/y/z/image
  # host/image -
  # user/image          user/x/y/z/image
  # host/user/image
  else {
    $image, $ref = $config.split(':')
    if ($config.split('/') -eq 3) {
      $registry, $image = $config.aplit('/', 2)
    }
  }

  if ($image.split('/').Count -ge 3 ) {
    $registry, $image = $image.split('/', 2)
  }
  else {
    if (!$registry) {
      if ($source) {
        $registry = $env:SOURCE_DOCKER_REGISTRY
      }
      else { $registry = $env:DEST_DOCKER_REGISTRY }
    }
  }

  if ($source) {
    $namespace = $env:SOURCE_NAMESPACE
  }
  else {
    $namespace = $env:DEST_NAMESPACE
  }

  if (!$namespace) { $namespace = "library" }

  if (!$image.contains('/')) {
    $image = "$namespace/$image"
  }

  # default source registry
  if (!$registry -and $source) {
    $registry = 'hub-mirror.c.163.com'
  }

  if (!$ref) { $ref = "latest" }

  if (!$registry) {
    write-host `
      "==> [error] [ $config ] parse error, `$env:DEST_DOCKER_REGISTRY NOT set" `
      -ForegroundColor DarkRed # DarkGray # Magenta # Cyan
  }

  write-host (Convertfrom-Json -InputObject @"
  {
      "registry": "$registry",
      "image": "$image",
      "ref": "$ref",
      "digest": "$digest"
  }
"@) -ForegroundColor Blue

  return $registry, $image, $ref, $digest
}

Export-ModuleMember -Function imageParser
