using System.Collections.Generic;
using System.Linq;
using Cdsi.SupportingData;

namespace Cdsi.ReferenceLibrary
{
    public static class ScheduleHelpers
    {
        public static IEnumerable<string> GetAntigenNames(this scheduleSupportingData schedule, string cvx)
        {
            return schedule.cvxToAntigenMap.First(x => x.cvx == cvx).association.Select(x => x.antigen);
        }

        public static string GetVaccineDescription(this scheduleSupportingData schedule, string cvx)
        {
            return schedule.cvxToAntigenMap.First(x => x.cvx == cvx).shortDescription;
        }
    }
}
