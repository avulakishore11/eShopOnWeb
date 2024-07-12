FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy the solution file
COPY src/PublicApi/PublicApi.csproj .

# Specify the solution file to restore dependencies
RUN dotnet restore 

# Copy the entire project
COPY . .

# Run tests
RUN dotnet test Everything.sln

# Publish the application
RUN dotnet publish  -c Release -o /app/publish

# Optional: Define the runtime image if needed
# FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
# WORKDIR /app
# COPY --from=build /app/publish .
# ENTRYPOINT ["dotnet", "YourProject.dll"]

# Copy all the project files to their respective directories (if needed)
#COPY src/**/*.csproj src/
#COPY tests/**/*.csproj tests/
