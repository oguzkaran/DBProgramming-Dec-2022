using CSD.SensorApp;
using CSD.SensorApp.Data;
using CSD.SensorApp.Data.Repository;
using CSD.SensorApp.Data.Service;
using CSD.Util.Mappers;
using CSD.Util.Mappers.Mapster;
using Microsoft.Extensions.DependencyInjection;
using SensorAppDAL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;

namespace SensorApp
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application
    {
        private readonly ServiceProvider m_serviceProvider;

        private void configureServices(ServiceCollection services)
        {
            services.AddSingleton<SensorsDBContext>()
                .AddSingleton<ISensorRepository, SensorRepository>()
                //.AddSingleton<SensorAppDataHelper>()
                .AddSingleton<IMapper, Mapper>()
                .AddSingleton<SensorAppService>()
                .AddSingleton<MainWindow>();

            Global.AddDependency(services);
        }

        private void onStartup(object sender, StartupEventArgs e)
        {
            var mainWindow = m_serviceProvider.GetService<MainWindow>();

            mainWindow.Show();
        }

        public App()
        {
            var services = new ServiceCollection();

            configureServices(services);
            m_serviceProvider = services.BuildServiceProvider();
        }
    }
}
