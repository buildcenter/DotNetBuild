Build the Scaffold
==================
The scaffold script is used to populate an empty directory into a repository.

```powershell
cd scaffolding
.\scaffold_builder.ps1
# Generated scaffold script lives in...
Get-Item ..\temp\scaffold.ps1
```

To use, just run the script in an empty folder. Let's assume `C:\scaffold.ps1` already exists.

```batchfile
C:\> md foo & cd foo
C:\foo> powershell -File ..\scaffold.ps1
```
