using System.Collections.Generic;

namespace Cdsi.Testcases
{
    public class Evaluation : IEvaluation
    {
        public string SeriesStatus { get; set; }
        public IEnumerable<IDose> AdministeredDoses { get; set; }
    }
}
