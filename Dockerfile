# escape=`

FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Install chocolatey
ADD https://chocolatey.org/install.ps1 C:\install.ps1
RUN @powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex C:\install.ps1" 

# Install Visual C++ Build Tools, as per: https://chocolatey.org/packages/visualcpp-build-tools
RUN choco install visualcpp-build-tools -version 14.0.25420.1 -y

# Add msbuild to PATH
RUN setx /M PATH "%PATH%;C:\Program Files (x86)\MSBuild\14.0\bin"

CMD [ "cmd.exe" ]