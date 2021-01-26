using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Xml.Serialization;
using Cdsi.SupportingData;
using Cdsi.Testcases;
using ExcelDataReader;

namespace Cdsi.ReferenceLibrary
{
    public static class Factories
    {
        // Antigen supporting data
        public static IDictionary<string, antigenSupportingData> CreateAntigenMap(DirectoryInfo inFolder)
        {
            var deserializer = new XmlSerializer(typeof(antigenSupportingData));

            return inFolder.GetFiles("*-508.xml")
                  .Select(x => x.OpenRead())
                  .Select(x => (antigenSupportingData)deserializer.Deserialize(x))
                  .Select(x => KeyValuePair.Create(x.series[0].targetDisease, x))
                  .AsMap();
        }

        public static IDictionary<string, string> CreateVaccineTypeMap(IDictionary<string, antigenSupportingData> antigenMap)
        {
            return antigenMap.Values
                    .SelectMany(x => x.series)
                    .SelectMany(x => x.seriesDose)
                    .SelectMany(x => x.preferableVaccine.Select(xx => KeyValuePair.Create(xx.cvx, xx.vaccineType))
                        .Concat(x.allowableVaccine.Select(xx => KeyValuePair.Create(xx.cvx, xx.vaccineType))))
                    .Where(x => !string.IsNullOrWhiteSpace(x.Key))
                    .Distinct(new KvpEqualityComparer())
                    .AsMap();
        }

        // Schedule supporting data

        public static scheduleSupportingData CreateSupportingData(FileInfo inFile)
        {
            var deserializer = new XmlSerializer(typeof(scheduleSupportingData));

            using var stream = inFile.OpenRead();
            return (scheduleSupportingData)deserializer.Deserialize(stream);
        }

        // Testcases

        public static IDictionary<string, ITestcase> CreateTestcaseMap(FileInfo inFile)
        {
            return GetDataSet(inFile).Tables[0].Rows.AsEnumerable()
                 .Select(x => x.AsTestcase())
                 .Select(x => KeyValuePair.Create(x.CdcTestId, x))
                 .AsMap();
        }

        private static DataSet GetDataSet(FileInfo inFile)
        {
            Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
            using var stream = inFile.OpenRead();
            using var reader = ExcelReaderFactory.CreateReader(stream);
            return reader.AsDataSet(new ExcelDataSetConfiguration()
            {
                UseColumnDataType = true,
                FilterSheet = (tableReader, sheetIndex) => sheetIndex == 2,
                ConfigureDataTable = (tableReader) => new ExcelDataTableConfiguration()
                {
                    UseHeaderRow = true
                }
            });
        }
    }
}
