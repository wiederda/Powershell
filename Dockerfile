FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt-get install -y --no-install-recommends && apt-get install -y tzdata
RUN apt-get -y install wget
RUN useradd -M -s /bin/bash -u 10001 -g 0 pwsh
RUN mkdir -p /home/power
RUN mkdir -p /home/scripts
WORKDIR /home/power
RUN wget -q https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb
RUN apt-get -y install ./packages-microsoft-prod.deb
RUN apt-get -y update
RUN apt-get -y install powershell
RUN rm -r /home/power
RUN chmod a+x /opt/microsoft/powershell/7/pwsh
RUN apt-get -y remove wget
RUN echo "pwsh version" > /home/scripts/Check.ps1
RUN echo "pwsh help" >> /home/scripts/Check.ps1
USER pwsh
CMD ["pwsh","./Check.ps1"]
