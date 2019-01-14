# The following PowerShell script divides the original 'Learn R by Example.R' file 
# into multiple ones and copies them into another output directory.

# As a note, some of the individual scripts may not work when run in isolation, 
# since some of the examples re-use the install_and_load_package function or 
# data from previous sections / examples. 

$InputFileName = "Learn R by Example.R"
$OutputDirectoryName = "Individual Scripts"

# Flag used to control whether you want to re-create the output directory containing
# the individual R files. If it's set to True, the output directory will be deleted
# prior to copying the files over and re-created. Otherwise, the scripts will be 
# copied over and any files already present within the output directory will be 
# overwritten.

$ReCreateOutputDirectory = $True

# Section delimiter which controls how the original R file is sub-divided. Currently,
# we mark each section beginning with the '##' comment characters followed by the 
# section title and contents which are used in splitting the original R file.

$SectionDelimiter = "##"

# Fetches the PowerShell script root directory path and returns it:

Function Get-RootDirectoryPath {
    
    $ScriptRoot = ""

    # Try to make sure that the script is compatible with both newer and older 
    # versions of PowerShell:

    Try {
        $ScriptRoot = Get-Variable -Name PSScriptRoot -ValueOnly -ErrorAction Stop
    } Catch {
        $ScriptRoot = Split-Path $script:MyInvocation.MyCommand.Path
    }

    return $ScriptRoot
}

$RootDirectoryPath = Get-RootDirectoryPath

$InputFilePath = (Join-Path $RootDirectoryPath $InputFileName)

$OutputDirectoryPath = (Join-Path $RootDirectoryPath $OutputDirectoryName)

# If the re-create directory path flag is set to true, delete the output 
# directory prior to copying the files over. 

If ($ReCreateOutputDirectory) {

    Remove-Item $OutputDirectoryPath -Recurse -ErrorAction Ignore

}

# Create the output directory (if it doesn't exist)

New-Item -ItemType Directory -Force -Path $OutputDirectoryPath

# Fetch the number of lines in our R file so we can create a progress indicator

$NumberOfLinesInFile = 0

gc $InputFilePath -read 100 | % { $NumberOfLinesInFile += $_.Length }

# Read the Learn R by Example file line by line:

$Reader = New-Object System.IO.StreamReader($InputFilePath)

Try {

    $SectionNumber = 1
    $LineNumber = 1

    While (($Line = $Reader.ReadLine()) -ne $null) {

        # If we find a new section delimiter / marker, we create a new file to output
        # our results to. The new file name will be set to a section number followed by 
        # the R section title which is provided after the delimiter we want to use.
        # I.E. the delimiter '##' in '## Section title' will create a new 'Section title.R'
        # file in our output directory. 

        If ($Line -match ($SectionDelimiter + " (.+\n?)")) {

            $SectionTitle = $matches[1].Trim()
            $OutputFileName = ($SectionNumber).ToString()  + ". " + $SectionTitle + ".R"
            $SectionNumber = $SectionNumber + 1

        }

        # Add the line we just processed to our output directory / file:

        Add-Content (Join-Path $OutputDirectoryPath $OutputFileName) $Line

        # Update the progress indicator to show percentage processed and line number count:

        $PercentComplete =  ($LineNumber / $NumberOfLinesInFile) * 100
        Write-Progress -Activity 'Processing R File' -Status "On line $LineNumber" -PercentComplete $PercentComplete

        $LineNumber = $LineNumber + 1

    }

} Finally {

    $Reader.Dispose()

}