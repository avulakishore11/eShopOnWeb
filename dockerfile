FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY src/Web/*.csproj Web/
COPY src/ApplicationCore/*.csproj ApplicationCore/
COPY src/Infrastructure/*.csproj Infrastructure/
RUN dotnet restore Web/Web.csproj

COPY src/ .

WORKDIR /src/Web
RUN dotnet publish Web.csproj -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "Web.dll"]
