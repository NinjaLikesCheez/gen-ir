# Releasing a New Version

`gen-ir` uses a [Brew Tap](https://docs.brew.sh/Taps) to distribute the tool, this document will show how to update that tap with the latest version of the tool.

In general, you need to do 3 things to make a release:

1. Update the [`gen_ir.swift`](../Sources/gen-ir/gen_ir.swift) command version string
2. Push and create a tag in the `gen_ir` repo
3. Update the homebrew tap

## Update gen_ir.swift

Find the `CommandConfiguration` initializer for the `gen_ir` tool, and bump the `version` parameter to match the version you want to release.

## Push and create a tag

Push a commit into `main` (preferably via a Merge Request) and tag it with an appropriate version:

```bash
git tag -a "v0.1" -m "Some awesome release notes"
git push --tags
```

## Update Brew Tap

Update the `NinjaLikesCheez/homebrew-tap` repo to include this new version in the formula:

1. Update the Formula's `tag` & `revision`
2. Create a Merge Request with the new formula changes
3. When the pipelines pass, add `pr-pull` label to the request
4. Bot will build bottles, and automatically merge the request if all succeeds