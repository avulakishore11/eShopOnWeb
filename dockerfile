FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy the solution file
COPY *.sln /app/src

# Copy all the project files to their respective directories
COPY src/**/*.csproj src/
COPY tests/**/*.csproj tests/


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
