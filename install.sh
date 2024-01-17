#!/bin/sh

html=$(wget -qO- https://github.com/PowerShell/PowerShell/releases/ | grep "linux-x64.tar.gz")
echo $html > /tmp/html.txt

output=$(awk -F" " '{print $1}' /tmp/html.txt)
echo $output > /tmp/output.txt
output=$(awk -F">" '{print $2}' /tmp/output.txt)
echo $output > /tmp/output.txt
version=$(awk -F"-" '{print $2}' /tmp/output.txt)

cd /tmp
wget -q https://github.com/PowerShell/PowerShell/releases/download/v${version}/${output}
tar zxf /tmp/${output} -C /opt/microsoft/powershell/7
chmod +x /opt/microsoft/powershell/7/pwsh
ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh
rm /tmp/${output} /tmp/html.txt /tmp/output.txt /tmp/Dockerfile

