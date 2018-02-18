Build Tools for .NET
====================
DotNetBuild is a build tool designed to simplify how we work with .NET family projects.

```batchfile
C:\> md repo && cd repo
C:\repo\> powershell -Command "& { wget https://raw.githubusercontent.com/buildcenter/DotNetBuild/master/scaffold.ps1 | iex }"
C:\repo\> build configure
C:\repo\> build debug *
C:\repo\> build clean debug *
C:\repo\> build release *
C:\repo\> echo my-secret-apikey > .\credentials\nuget.org.repokey
C:\repo\> build publish .\releases\my.very.cool.lib.1.0.0.nupkg
```

Congrats! You have just built your assembly and published it as a package on NuGet.org. Say what?


Why not Visual Studio
=====================
Why not indeed! DotNetBuild is not meant to replace your favorite IDE with console and notepad. Instead, it works as a human friendly layer on top of the XML based makefile that MSBuild uses. 
DotNetBuild takes care of generating the right artifacts, so you can concentrate on the codes that matter.

Compared to VS, DotNetBuild uses a JSON-like format to configure your build:

* `global.bsd`  - Only one per repo. Applies to all projects. It looks [like this](./src/global.bsd).
* `project.bsd` - One per project. You can append or override global settings in here. Here is [a sample](./src/MyFoo.CSharpLib/project.bsd).


Configure Your Build
====================
The command `build configure` creates a working directory and do the following things:

* Copies out your source code to the working directory
* Download the .NET SDK if needed and sets up the `dotnet` cli environment
* Creates global level artifacts such as solution file, nuget configuration, global.json, etc.
* Generates project makefiles for MSBuild such as `csproj`
* Generates `AssemblyInfo` metadata code (which you configure in `global.bsd` and `project.bsd`)
* Creates localization resources automatically from a special `Properties/StringData.txt` file in your project.
* Process text templates in your codes using PowerShell syntax.

The working directory is compatible with Visual Studio for the most part. You can open up your solution file using VS, try out code changes, debug, build and perform unit tests. When you are 
done, remember to copy your new code back to the source folder.

There is no need to work with files like `Properties/AssemblyInfo.cs`, `.resx` or `csproj`. Just edit your `project.bsd` and run `build configure` to churn out the artifacts.


Building
========
In a CLI environment (such as a CI server), DotNetBuild can compile your build too:

1. Remember to run `build configure` first.
2. Run `build debug *` to compile all projects in debug configuration, or `build debug [project1] [project2]` to compile selected projects.
3. Name your test projects "[project].Tests" to automatically run unit tests after compiling.
4. If needed, clean your build output using `build clean debug *`. You can also clean selected projects using `build clean debug [project1] [project2]`
5. Build for release configuration by substituting 'debug' in step 2 for 'release': `build release *`
6. Release builds produce `nupkg` files too!

DotNetBuild will compile for all target frameworks, runtimes and CPU platforms per your `project.bsd` settings.


Publishing
==========
Share your package with the world or your private NuGet server: 

```batchfile
C:\> build publish .\releases\mylibrary.1.0.0.nupkg
```

Again, you will specify NuGet servers via `global.bsd` or `project.bsd` configuration. DotNetBuild will automatically push to all servers in your configuration.


Schema
======
The sample source in [/src/global.bsd](./src/global.bsd) and [/src/MyFoo.CSharpLib/project.bsd](./src/MyFoo.CSharpLib/project.bsd) are rich commented. You should be able figure everything out just by looking at the comments.

Specific schematics are documented [in the docs](http://buildcenter.github.io/DotNetBuild/schema.md).

Since everything is script and template driven, you should just [look at the source](./tools/DotNetBuilder) whenever in doubt.


Contributing
============
If you are interested in fixing issues and contributing directly to the code base,
please see the document [How to Contribute](https://buildcenter.github.io/how-to-contribute.md), which covers the following:

* [The development workflow, including debugging and running tests](https://buildcenter.github.io/how-to-contribute.md#development-workflow)
* [Coding Guidelines](https://buildcenter.github.io/coding-guidelines.md)
* [Submitting pull requests](https://buildcenter.github.io/how-to-contribute.md#pull-requests)
* [Contributing to translations](https://buildcenter.github.io/how-to-contribute.md#translations)

Please see also our [Code of Conduct](https://buildcenter.github.io/code-of-conduct.md).


Feedback
========
* Request a new feature [right here](https://buildcenter.github.io/how-to-contribute).
* Ask a question on [Stack Overflow](https://stackoverflow.com/questions/tagged/dotnetbuild).
* Vote for [popular feature requests](https://github.com/buildcenter/DotNetBuild/issues?q=is%3Aopen+is%3Aissue+label%3Afeature-request+sort%3Areactions-%2B1-desc).
* File a bug in [GitHub Issues](https://github.com/buildcenter/DotNetBuild/issues).
* [Tweet](https://twitter.com/lizoc) us with other feedback.

Related Projects
================
DotNetBuild dependencies live in their own repositories on GitHub:
* [Builder](https://www.github.com/buildcenter/Builder)
* [PSTemplate](https://www.github.com/buildcenter/PSTemplate)
* [PSCONFIGON](https://www.github.com/buildcenter/PSConfigon)


License
=======
Copyright (c) Lizoc Corporation. All rights reserved.

Licensed under the [MIT](LICENSE) License.
