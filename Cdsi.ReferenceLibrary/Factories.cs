using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
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
            var assembly = Assembly.GetAssembly(typeof(Metadata));

            return assembly.GetManifestResourceNames()
                  .Select(x => Tuple.Create(x, re.Match(x)))
                  .Where(x => x.Item2.Success)
                  .Select(x => assembly.GetManifestResourceStream(x.Item1))
                  .Select(x => (antigenSupportingData)deserializer.Deserialize(x))
                  .Select(x => KeyValuePair.Create(x.series[0].targetDisease, x))
                  .AsMap();
        }

        public static IDictionary<string, string> CreateVaccineTypeMap()
        {
            return Reference.Antigen.Values
                    .SelectMany(x => x.series)
                    .SelectMany(x => x.seriesDose)
                    .SelectMany(x => x.preferableVaccine.Select(xx => KeyValuePair.Create(xx.cvx, xx.vaccineType))
                        .Concat(x.allowableVaccine.Select(xx => KeyValuePair.Create(xx.cvx, xx.vaccineType))))
                    .Where(x => !string.IsNullOrWhiteSpace(x.Key))
                    .Distinct(new KvpEqualityComparer())
                    .AsMap();
        }

        // Schedule supporting data

        public static scheduleSupportingData CreateSupportingData(DirectoryInfo inFolder)
        {
            var name = "Cdsi.SupportingData.xml.ScheduleSupportingData.xml";
            var assembly = Assembly.GetAssembly(typeof(Metadata));
            var resource = assembly.GetManifestResourceStream(name);
            var deserializer = new XmlSerializer(typeof(scheduleSupportingData));
            return (scheduleSupportingData)deserializer.Deserialize(resource);
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
            var assembly = Assembly.GetAssembly(typeof(TestcaseData.Metadata));

            using var stream = assembly.GetManifestResourceStream(ResourceName);
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
