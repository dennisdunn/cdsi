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

            var fileInfo = new FileInfo(@"C:\Users\Dennis\source\repos\data\xlsx\cdsi-healthy-childhood-and-adult-test-cases-v4.4.xlsx");

            var data = Factories.CreateTestcaseMap(fileInfo);

            File.WriteAllText(@"C:\Users\Dennis\source\repos\data\testcases.json", JsonSerializer.Serialize(data, options));
        }
    }
}
