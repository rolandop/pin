FROM mcr.microsoft.com/dotnet/sdk:7.0 as build
LABEL project=voting-app
WORKDIR /source
COPY *.csproj /source
RUN dotnet restore
COPY . /source
RUN dotnet publish -c release -o /app --self-contained false --no-restore


FROM mcr.microsoft.com/dotnet/runtime:7.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "Worker.dll"]