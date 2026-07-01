# Docker Buildx bake configuration for CosmOS builds
variable "REGISTRY" {
  default = "docker.io"
}

variable "IMAGE_PREFIX" {
  default = "cosmos"
}

variable "VERSION" {
  default = "latest"
}

group "default" {
  targets = [
    "develop",
    "bench-test"
  ]
}

target "develop" {
  dockerfile = "Dockerfile"
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
  tags = [
    "${REGISTRY}/${IMAGE_PREFIX}/develop:${VERSION}",
    "${REGISTRY}/${IMAGE_PREFIX}/develop:latest"
  ]
}

target "bench-test" {
  dockerfile = "Dockerfile.bench"
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
  tags = [
    "${REGISTRY}/${IMAGE_PREFIX}/bench:${VERSION}",
    "${REGISTRY}/${IMAGE_PREFIX}/bench:latest"
  ]
}
