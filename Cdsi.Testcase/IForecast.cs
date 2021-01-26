using System;

namespace Cdsi.Testcases
{
    public interface IForecast
    {
        DateTime EarliestDate { get; }
        string ForecastNum { get; }
        DateTime PastDueDate { get; }
        DateTime RecommendedDate { get; }
    }
}