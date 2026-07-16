# syntax=docker/dockerfile:1
# ──────────────────────────────────────────────────────────────────
# Stage 1: Build
# ──────────────────────────────────────────────────────────────────
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

# Copy project file and restore dependencies (layer-cached)
COPY ["WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj", "WebApp-Storage-DotNet/"]
RUN dotnet restore "WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj"

# Copy remaining source and publish
COPY WebApp-Storage-DotNet/ WebApp-Storage-DotNet/
WORKDIR /src/WebApp-Storage-DotNet
RUN dotnet publish "WebApp-Storage-DotNet.csproj" \
    -c Release \
    -o /app/publish \
    --no-restore

# ──────────────────────────────────────────────────────────────────
# Stage 2: Runtime
# ──────────────────────────────────────────────────────────────────
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS runtime
WORKDIR /app

# Create a non-root user for security (Debian-based image)
RUN groupadd --system --gid 1001 appgroup \
 && useradd  --system --uid 1001 --gid appgroup --no-create-home appuser

# Copy published output from build stage
COPY --from=build /app/publish .

# Ensure the non-root user owns the app files
RUN chown -R appuser:appgroup /app

USER appuser

# ASP.NET Core listens on port 8080 by default when not running as root
ENV ASPNETCORE_URLS=http://+:8080
ENV ASPNETCORE_ENVIRONMENT=Production

EXPOSE 8080

ENTRYPOINT ["dotnet", "WebApp-Storage-DotNet.dll"]
