using System.IO;
using System.Text.Json;
using Cdsi.ReferenceLibrary;

namespace Cdsi.Apps
{
    class Program
    {
        static void Main(string[] args)
        {
            var options = new JsonSerializerOptions
            {
                PropertyNamingPolicy = JsonNamingPolicy.CamelCase
                // etc.
            };

            var fileInfo = new FileInfo(@"C:\Users\Dennis\source\repos\data\xml\ScheduleSupportingData.xml");

            var data = Factories.CreateSupportingData(fileInfo);

            File.WriteAllText(@"C:\Users\Dennis\source\repos\data\schedule.json", JsonSerializer.Serialize(data, options));
        }
    }
}
