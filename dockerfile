# Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Set environment variables for the solution and project files
ENV SOLUTION_FILE=Everything.sln
ENV WEB_PROJECT_PATH=src/Web
ENV WEB_PROJECT_FILE=Web.csproj

# Copy the solution and project files
COPY $SOLUTION_FILE ./
COPY src/ApplicationCore/ApplicationCore.csproj src/ApplicationCore/
COPY src/BlazorAdmin/BlazorAdmin.csproj src/BlazorAdmin/
COPY src/BlazorShared/BlazorShared.csproj src/BlazorShared/
COPY src/Infrastructure/Infrastructure.csproj src/Infrastructure/
COPY src/PublicApi/PublicApi.csproj src/PublicApi/
COPY src/Web/Web.csproj src/Web/
COPY tests/FunctionalTests/FunctionalTests.csproj tests/FunctionalTests/
COPY tests/IntegrationTests/IntegrationTests.csproj tests/IntegrationTests/
COPY tests/PublicApiIntegrationTests/PublicApiIntegrationTests.csproj tests/PublicApiIntegrationTests/
COPY tests/UnitTests/UnitTests.csproj tests/UnitTests/

# Restore dependencies for the solution
RUN dotnet restore $SOLUTION_FILE

# Copy the entire source code
COPY . .

# Run tests for all specified test projects
WORKDIR /app/tests/FunctionalTests
RUN dotnet test FunctionalTests.csproj

WORKDIR /app/tests/IntegrationTests
RUN dotnet test IntegrationTests.csproj

WORKDIR /app/tests/PublicApiIntegrationTests
RUN dotnet test PublicApiIntegrationTests.csproj

WORKDIR /app/tests/UnitTests
RUN dotnet test UnitTests.csproj

# Publish the Web project
WORKDIR /app/$WEB_PROJECT_PATH
RUN dotnet publish $WEB_PROJECT_FILE -c Release -o /app/publish

# Stage 2: Create the runtime image
# FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
# WORKDIR /app
# COPY --from=build /app/publish .
# ENTRYPOINT ["dotnet", "Web.dll"]
