using System;

namespace Cdsi.Testcases
{
    public interface IDose
    {
        string CVX { get;  }
        DateTime DateAdministered { get;  }
        string EvaluationReason { get;  }
        string EvaluationStatus { get;  }
        string MVX { get;  }
        string VaccineName { get;  }
    }
}