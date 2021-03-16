FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /source
COPY web-app.csproj .
RUN dotnet restore web-app.csproj
COPY . .
RUN dotnet build web-app.csproj -c Release --no-restore
RUN dotnet publish web-app.csproj -c Release --no-build -o /app

FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "web-app.dll"]