

Welcome to the WindowsScript Repository !

To run PowerShell script:

    Press windows key
    Type PowerShell and run application
    Navigate to your script path
    Execute it with following command: ./yourscript.ps1

Problems ?

I got error message on running:

cannot be loaded because the execution of scripts is disabled on this system. Please see "get-help about_signing" for more details.

Solution:

    Type: Set-ExecutionPolicy Unrestricted
    Validate with Y

