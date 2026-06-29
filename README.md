---
languages:
- csharp
products:
- azure
- azure-storage
page_type: sample
---

# .NET Photo Gallery Web Application Sample with Azure Blob Storage

This sample application creates a web photo gallery that allows you to host and view images through a .NET web frontend. The code sample also includes functionality for deleting images. At the end, you have the option of deploying the application to Azure.

![Azure Blob Storage Photo Gallery Web Application Sample .NET](./images/photo-gallery.png)

## Technologies used
- ASP.NET Core MVC
- .NET 10
- Azurite or Azure Storage emulator-compatible local storage
- Azure App Service
- Azure Blob Storage

Azure Blob Storage Photo Gallery Web Application using ASP.NET Core MVC. The sample uses the Azure Storage .NET client library's asynchronous APIs to upload, list, and delete blobs from a photo gallery web front end.

## Running this sample
1. Before you can run this sample, you must have the following prerequisites:
	- .NET 10 SDK.
	- Azurite, or another Azure Storage connection string you can use for development.

2. Open the Azure Storage emulator. Once the emulator is running it will be able to process the images from the application.

3. Clone this repository using Git for Windows (http://www.git-scm.com/), or download the zip file.

4. Update `WebApp-Storage-DotNet/appsettings.json` with the storage connection string you want to use locally.

5. From the repository root, run `dotnet build WebApp-Storage-DotNet.sln`.

6. Run the app with `dotnet run --project WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj` and browse to the local URL shown in the console output.

## Deploy this sample to Azure

1. To make the sample work in the cloud, you must replace the connection string with the values of an active Azure Storage Account. If you don't have an account, refer to the [Create a Storage Account](https://azure.microsoft.com/en-us/documentation/articles/storage-create-storage-account/) article.

2. Retrieve the STORAGE ACCOUNT NAME and PRIMARY ACCESS KEY (or SECONDARY ACCESS KEY) values from the Keys blade of your Storage account in the Azure Preview portal. For more information on obtaining keys for your Storage account refer to [View, copy, and regenerate storage access keys](https://azure.microsoft.com/en-us/documentation/articles/storage-create-storage-account/#view-copy-and-regenerate-storage-access-keys)

2. In `WebApp-Storage-DotNet/appsettings.json`, update the **StorageConnectionString** setting with the values obtained for your account.

  "StorageConnectionString": "DefaultEndpointsProtocol=https;AccountName=[Enter Your Storage AccountName];AccountKey=[Enter Your Storage AccountKey]"

3. In Visual Studio Solution Explorer, right-click on the project name and select **Publish...**

4. Using the Publish Website dialog, select **Microsoft Azure Web Apps**

5. In the next dialog, either select an existing web app, or follow the prompts to create a new web application. Note: If you choose to create a web application, the Web App Name chosen must be globally unique.

6. Once you have selected the web app, click **Publish**

7. After a short time, Visual Studio will complete the deployment and open a browser with your deployed application.

For additional ways to deploy this web application to Azure, please refer to the [Deploy a web app in Azure App Service](https://azure.microsoft.com/en-us/documentation/articles/web-sites-deploy/) article which includes information on using Azure Resource Manager (ARM) Templates, Git, MsBuild, PowerShell, Web Deploy, and many more.

## About the code
The code included in this sample is meant to be a quick start sample for learning about Azure Web Apps and Azure Storage. It is not intended to be a set of best practices on how to build scalable enterprise grade web applications.

## More information
- [What is a Storage Account](http://azure.microsoft.com/en-us/documentation/articles/storage-whatis-account/)
- [Getting Started with Blobs](http://azure.microsoft.com/en-us/documentation/articles/storage-dotnet-how-to-use-blobs/)
- [Blob Service Concepts](http://msdn.microsoft.com/en-us/library/dd179376.aspx)
- [Blob Service REST API](http://msdn.microsoft.com/en-us/library/dd135733.aspx)
- [Blob Service C# API](http://go.microsoft.com/fwlink/?LinkID=398944)
- [Delegating Access with Shared Access Signatures](http://azure.microsoft.com/en-us/documentation/articles/storage-dotnet-shared-access-signature-part-1/)
