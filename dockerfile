



FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY *.sln .
COPY src/ApplicationCore/*.csproj .
COPY src/ApplicationCore/Specifications/*.csproj .
COPY src/BlazorAdmin/*csproj .
COPY src/BlazorShared/*.csproj .
COPY src/Web/*.csproj .
COPY tests/IntegrationTests/*csproj .
COPY tests/UnitTests/*csproj .
COPY FunctionalTests/*.csproj .

RUN dotnet restore 
COPY . .
RUN dotnet test
RUN dotnet publish  -c Release -o /app/publish

