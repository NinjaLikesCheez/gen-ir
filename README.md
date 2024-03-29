<h1 align="center">
  <br>Gen IR 🧞‍♂️<br>
</h1>

<h4 align="center">
  Generate LLVM IR from an Xcode Build Log
</h4>

<p align="center">
 <a href="https://github.com/NinjaLikesCheez/gen-ir/actions/workflows/build.yml">
    <img src="https://github.com/NinjaLikesCheez/gen-ir/actions/workflows/build.yml/badge.svg?branch=main" />
  </a>
  <a href="">
    <img src="https://img.shields.io/github/v/release/NinjaLikesCheez/gen-ir" />
  </a>

</p>

This tool was heavily inspired by: https://blog.digitalrickshaw.com/2016/03/14/dumping-the-swift-ast-for-an-ios-project-part-2.html ❤️


<h2 align="center">
Note: This repo has now moved to <a href="https://github.com/veracode/gen-ir">veracode/gen-ir</a>
</h> 

## Prerequisites

To **build** the tool, you'll need Xcode 14 and macOS 12.5 or greater.

To **install and run** the tool, you'll need Homebrew, Xcode, and macOS 12 or greater.

## Install

```bash
# If you don't have brew installed, install it: https://brew.sh/

# Add the brew tap to your local machine
brew tap NinjaLikesCheez/tap

# Install the tool
brew install gen-ir
```

## 🎉 Done!

All installed! You can now use `gen-ir` on your system - be sure to run `gen-ir --help` to check the available commands and options.

## Usage

> ### ⚠️ Before you use
>It's important to know that `gen-ir` requires that a **full** build log is provided.
>
>**This means a clean, fresh build of a project.**
>
>The compiler will **not** make a call for an object that doesn't need to be rebuilt, and we will not be able to parse what doesn't exist. Ensure you do a clean before your build otherwise `gen-ir` may miss some modules.

`gen-ir` takes a Xcode build log by two means, a path to a file or stdin:

```bash
# Path to build log (you can export from inside of Xcode too)
xcodebuild clean && \
xcodebuild build -project TestProject.xcodeproj -scheme TestProject -configuration Debug > build_log.txt

gen-ir build_log.txt ir_files/

# Stdin (you may need to redirect stderr to stdout here, Xcode is weird about writing to it sometimes)
xcodebuild clean && \
xcodebuild build -project TestProject.xcodeproj -scheme TestProject -configuration Debug | gen-ir - ir_files/
```

## Building

`gen-ir` is implemented as a Swift Package, so you can either open [`Package.swift`](Package.swift) in Xcode, or build via the command line:

```sh
# Debug output: ./.build/debug/gen-ir
swift build

# Release output: ./.build/release/gen-ir
swift build -c release
```
