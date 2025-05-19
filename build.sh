#!/bin/zsh

set -xe;

VERSIONS=("8.2" "8.3" "8.4")
REPO="rustic/php-fpm"
PLATFORMS="linux/amd64,linux/arm64,linux/arm/v7"

# Prerequisites
# Docker with buildx enabled (docker buildx create --use)
# Also: docker run --privileged --rm tonistiigi/binfmt --install all 
# Logged in to Docker Hub (docker login)
# The Dockerfile should be in the parent directory 8.x of the Dockerfile

get_full_version() {
    local version=$1
    docker run --rm "php:$version-fpm-alpine" php -r 'echo PHP_VERSION;'
}

# Get full versions for comparison and tagging
typeset -A FULL_VERSIONS
for version in $VERSIONS; do
    echo "⏳ Fetching full version for PHP $version..."
    FULL_VERSIONS[$version]=$(get_full_version $version)
done

# Determine latest version
LATEST_VERSION=$(for v in ${(k)FULL_VERSIONS}; do echo $FULL_VERSIONS[$v]; done | sort -Vr | head -n 1)

# Start building
for version in $VERSIONS; do
    full_version=$FULL_VERSIONS[$version]
    major_tag="${version}-fpm-alpine"
    full_tag="${full_version}-fpm-alpine"
    tags=(-t "$REPO:$major_tag" -t "$REPO:$full_tag")

    if [[ "$full_version" == "$LATEST_VERSION" ]]; then
        tags+=(-t "$REPO:latest")
    fi

    echo "🚧 Building PHP $version (full: $full_version)..."

    docker buildx build \
        --file "8.x/Dockerfile" \
        --platform $PLATFORMS \
        --build-arg VERSION=$version \
        --push \
        $tags \
        "8.x"
done

echo "✅ All images built and pushed successfully!"
