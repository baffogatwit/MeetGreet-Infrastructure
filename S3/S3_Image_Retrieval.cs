using Amazon.Runtime;
using Amazon.S3;
using Amazon.S3.Model;
using Amazon.Extensions.NETCore.Setup;
using static Amazon.RegionEndpoint;

// Sample Object Name: "230330-4681c160-240b-4eb7-a805-a37ef49abed1"
public class S3_Image_Retrieval
{
    private final BUCKET_NAME = "meetgreet-image-store";
    private final TIMEOUT_DURATION = 6;
    public static async Task Main()
    {
        string url = getImageFromS3("230330-4681c160-240b-4eb7-a805-a37ef49abed1");
    }

    private string getImageFromS3(string s3Key)
    {
        var credentials = new BasicAWSCredentials("", "");

        IAmazonS3 s3Client = new AmazonS3Client(credentials, Amazon.RegionEndpoint.USEast1);

        return GeneratePresignedURL(s3Client, bucketName, s3Key, TIMEOUT_DURATION);;
    }

    /// <summary>
    /// Generate a presigned URL that can be used to access the file named
    /// in the objectKey parameter for the amount of time specified in the
    /// duration parameter.
    /// </summary>
    /// <param name="client">An initialized S3 client object used to call
    /// the GetPresignedUrl method.</param>
    /// <param name="bucketName">The name of the S3 bucket containing the
    /// object for which to create the presigned URL.</param>
    /// <param name="objectKey">The name of the object to access with the
    /// presigned URL.</param>
    /// <param name="duration">The length of time for which the presigned
    /// URL will be valid.</param>
    /// <returns>A string representing the generated presigned URL.</returns>
    public static string GeneratePresignedURL(IAmazonS3 client, string bucketName, string objectKey, double duration)
    {
        string urlString = string.Empty;
        try
        {
            var request = new GetPreSignedUrlRequest()
            {
                BucketName = bucketName,
                Key = objectKey,
                Expires = DateTime.UtcNow.AddHours(duration),
            };
            urlString = client.GetPreSignedURL(request);
        }
        catch (AmazonS3Exception ex)
        {
            Console.WriteLine($"Error:'{ex.Message}'");
        }

        return urlString;
    }


}