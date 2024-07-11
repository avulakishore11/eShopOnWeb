# STEP 1: Setup the base image for SDK to build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Setup working directory
WORKDIR /source

# Copy the .csproj and .sln files to restore dependencies
COPY global.json ./
COPY Everything.sln ./
COPY src/ApplicationCore/ApplicationCore.csproj ./
COPY src/BlazorAdmin/BlazorAdmin.csproj ./

# Restore the dependencies
RUN dotnet restore Everything.sln
RUN dotnet restore src/ApplicationCore/ApplicationCore.csproj
RUN dotnet restore src/BlazorAdmin/BlazorAdmin.csproj

# Run the test cases
RUN dotnet test Everything.sln
RUN dotnet test src/ApplicationCore/ApplicationCore.csproj
RUN dotnet test src/BlazorAdmin/BlazorAdmin.csproj

# Build the application using dotnet publish
RUN dotnet publish -c Release -o /app/published
