
using System;
using Amazon.Runtime;
using Amazon.S3;
using Amazon.S3.Model;
using Amazon.Extensions.NETCore.Setup;
using static Amazon.RegionEndpoint;

// Connect to AWS SQL Table: mysql -h meetgreet-dev.ccg48bpsuvv6.us-east-2.rds.amazonaws.com -u admin -p

public class S3_Image_Upload
{
    private final BUCKET_NAME = "meetgreet-image-store";

    public static async Task Main()
    {
        uploadEventImages("ApplePark.jpg");
    }

    private void uploadEventImages(string filePath)
    {
        var credentials = new BasicAWSCredentials("", "");
        IAmazonS3 s3Client = new AmazonS3Client(credentials, Amazon.RegionEndpoint.USEast1);
        string objectName = generateValidObjectName();
        await UploadFileAsync(s3Client, BUCKET_NAME, objectName, filePath);
    }

    private string generateValidObjectName()
    {
        String offeredName = generateObjectName();
        while (checkIfObjectNameExists(offeredName) == true)
        {
            offeredName = generateObjectName();
        }
        return offeredName;
    }

    private string generateObjectName()
    {
        return DateTime.Now.ToString("yyMMdd") + "-" + Guid.NewGuid().ToString();
    }

    private Boolean checkIfObjectNameExists(String proposedKey)
    {
        //foreach (var image in _context.EventImage)
        //{
        //    if (image.s3Key == proposedKey)
        //    {
        //        return true;
        //    }
        //}
        return false;
    }

    /// <param name="client">An initialized Amazon S3 client object.</param>
    /// <param name="bucketName">The Amazon S3 bucket to which the object
    /// will be uploaded.</param>
    /// <param name="objectName">The object to upload.</param>
    /// <param name="filePath">The path, including file name, of the object
    /// on the local computer to upload.</param>
    /// <returns>A boolean value indicating the success or failure of the
    /// upload procedure.</returns>
    private static async Task<bool> UploadFileAsync(
        IAmazonS3 client,
        string bucketName,
        string objectName,
        string filePath)
    {
        var request = new PutObjectRequest
        {
            BucketName = bucketName,
            Key = objectName,
            FilePath = filePath,
        };

        var response = await client.PutObjectAsync(request);
        if (response.HttpStatusCode == System.Net.HttpStatusCode.OK)
        {
            Console.WriteLine($"Successfully uploaded {objectName} to {bucketName}.");
            //uploadEventImageToDatabase(objectName, url);

            return true;
        }
        else
        {
            Console.WriteLine($"Could not upload {objectName} to {bucketName}.");
            return false;
        }
    }

    //private static async void uploadEventImageToDatabase(String s3Key, String imageURL)
    //{
    //    EventImage image = new EventImage();
    //    image.s3Key = s3Key;
    //    image.imageURL = imageURL;
    //    _context.Add(image);
    //    await _context.SaveChangesAsync();
    //}
}


