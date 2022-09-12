# ``gen_ir``

`gen-ir` enables developers to generate LLVM Bitcode from an Xcode Build Log.

## Overview

In Xcode 14, Apple deprecated the `ENABLE_BITCODE` setting, meaning it will eventually be removed, and making it harder to get bitcode for your project.

This tool aims to rectify that by parsing the compiler commands from an Xcode build run (either via a build log file on disk, or via stdin), modifying those commands to produce bitcode files, and then running the modified commands and collating the outputs.

<!-- Add How to guide here -->
<!--## Topics-->
<!---->
<!--### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->-->
<!---->
<!--- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->-->
