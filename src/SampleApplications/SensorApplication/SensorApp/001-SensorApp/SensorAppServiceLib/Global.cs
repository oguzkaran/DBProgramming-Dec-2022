using CSD.SensorApp.Data.Service;
using Microsoft.Extensions.DependencyInjection;
using SensorAppDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CSD.SensorApp
{
    public static class Global
    {
        public static void AddDependency(ServiceCollection services)
        {
            services.AddSingleton<SensorAppDataHelper>();
        }
    }
}
