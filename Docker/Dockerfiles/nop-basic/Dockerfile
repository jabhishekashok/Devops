FROM mcr.microsoft.com/dotnet/sdk:7.0
LABEL auth="Abhishek" org="TEST"
ADD https://github.com/nopSolutions/nopCommerce/releases/download/release-4.60.2/nopCommerce_4.60.2_NoSource_linux_x64.zip /nop/nopCommerce_4.60.2_NoSource_linux_x64.zip
WORKDIR /nop
RUN sudo apt-get install unzip && \
sudo unzip nopCommerce_4.60.2_NoSource_linux_x64.zip && \
sudo mkdir bin && \
sudo mkdir logs
EXPOSE 5000
CMD [ "dotnet", "Nop.Web.dll" , "--urls", "http://0.0.0.0:5000"]