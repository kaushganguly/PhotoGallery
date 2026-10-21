---
languages:
- csharp
products:
- azure
- azure-storage
page_type: sample
---

# .NET Photo Gallery with Azure Blob Storage

This sample is an ASP.NET Core MVC photo gallery on .NET 10. It uploads images to Azure Blob Storage, displays stored images, and supports deleting individual images or the entire gallery.

## Prerequisites

- .NET 10 SDK
- An Azure Storage account, or Azurite for local development

## Run locally

The default `StorageConnectionString` in `WebApp-Storage-DotNet/appsettings.json` uses Azurite's development storage connection string. Start Azurite, then run:

```sh
dotnet run --project WebApp-Storage-DotNet
```

To use an Azure Storage account, set `StorageConnectionString` in configuration or as an environment variable. For example:

```sh
StorageConnectionString="DefaultEndpointsProtocol=https;AccountName=<account-name>;AccountKey=<account-key>;EndpointSuffix=core.windows.net"
```

Do not commit real storage credentials. The gallery creates the `webappstoragedotnet-imagecontainer` container and allows public blob reads so uploaded images can be viewed directly.

## Build and test

```sh
dotnet build WebApp-Storage-DotNet.sln
dotnet test WebApp-Storage-DotNet.sln
```

## Deploy to Azure

Deploy the ASP.NET Core application to Azure App Service and configure the `StorageConnectionString` application setting with the connection string for your storage account.

## More information

- [Azure Blob Storage overview](https://learn.microsoft.com/azure/storage/blobs/storage-blobs-introduction)
- [Use the Azure Storage Blob client library for .NET](https://learn.microsoft.com/azure/storage/blobs/storage-blob-dotnet-get-started)
