using System.Collections.Generic;

namespace Cdsi.Testcases
{
    public interface IEvaluation
    {
        IEnumerable<IDose> AdministeredDoses { get; }
        string SeriesStatus { get; }
    }
}