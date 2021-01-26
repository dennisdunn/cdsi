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

            var dirInfo = new DirectoryInfo(@"C:\Users\Dennis\source\repos\data\xml");

            var data = Factories.CreateAntigenMap(dirInfo);

            File.WriteAllText(@"C:\Users\Dennis\source\repos\data\antigens.json", JsonSerializer.Serialize(data, options));
        }
    }
}
