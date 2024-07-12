FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy the solution file
COPY *.sln .

# Copy all the project files to their respective directories
COPY src/ApplicationCore/*.csproj src/ApplicationCore/
COPY src/ApplicationCore/Specifications/*.csproj src/ApplicationCore/Specifications/
COPY src/BlazorAdmin/*.csproj src/BlazorAdmin/
COPY src/BlazorShared/*.csproj src/BlazorShared/
COPY src/Web/*.csproj src/Web/
COPY tests/IntegrationTests/*.csproj tests/IntegrationTests/
COPY tests/UnitTests/*.csproj tests/UnitTests/
COPY tests/FunctionalTests/*.csproj FunctionalTests/

# Restore dependencies
RUN dotnet restore

# Copy the entire project
COPY . .

# Run tests
RUN dotnet test

# Publish the application
RUN dotnet publish -c Release -o /app/publish

# Optional: Define the runtime image if needed
# FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
# WORKDIR /app
# COPY --from=build /app/publish .
# ENTRYPOINT ["dotnet", "YourProject.dll"]
