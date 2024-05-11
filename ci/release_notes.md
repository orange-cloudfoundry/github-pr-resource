### Improvements

- New metadata file that supports the new `load_var` Concourse statement (PR #7 by @bgandon, initially submitted as PR telia-oss/github-pr-resource#276, fixing issue telia-oss/github-pr-resource#248)
- Add PR body in the metadata provided by 'get' steps (PR #8 by @bgandon, initially submitted as PR telia-oss/github-pr-resource#277, fixing issue telia-oss/github-pr-resource#194)
- Fix defect with bot users when `delete_previous_comments` is enabled (originally submitted as telia-oss/github-pr-resource#245 and fixed later in monzo/github-pr-resource#4, thanks @bee-san)
- Bumped the [go-github](https://github.com/google/go-github) API to v61, the latest available.
- Bumped other Go dependencies to latest versions.
- Built with latest go 1.21 patch version (i.e. v1.21.10)
