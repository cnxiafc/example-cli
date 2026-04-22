# example

This repository contains an advanced example GitLab CI pipeline leveraging 
[GoReleaser](https://goreleaser.com/) to release  compiled archives and push container images of a Go application.

In a more straightforward scenario where only archives and/or binaries are the desired product of 
your pipeline, your `.gitlab-ci.yml` might look something like:

```yaml
stages:
  - release
release:
  stage: release
  image:
    name: goreleaser/goreleaser
    entrypoint: ['']
  only:
    - tags
  variables:
    # Disable shallow cloning so that goreleaser can diff between tags to
    # generate a changelog.
    GIT_DEPTH: 0
  script:
    - goreleaser release --rm-dist
```

Notice that `entrypoint` is intentionally blank. See the 
[GitLab documentation on entrypoints](https://docs.gitlab.com/ee/ci/docker/using_docker_images.html#overriding-the-entrypoint-of-an-image) 
for more information.
