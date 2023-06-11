using CSD.SensorApp.Data;
using CSD.SensorApp.Data.Repository;
using CSD.Util.Data.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using static CSD.Data.DatabaseUtil;

namespace SensorAppDAL
{
    public class SensorAppDataHelper //Facade
    {
        private readonly ISensorRepository m_sensorRepository;
        private readonly IPortRepository m_portRepository;

        public SensorAppDataHelper(ISensorRepository sensorRepository)
        {
            m_sensorRepository = sensorRepository;
        }

        //public SensorAppDataHelper(ISensorRepository sensorRepository, IPortRepository portRepository)
        //{
        //    m_sensorRepository = sensorRepository;
        //    m_portRepository = portRepository;
        //}


        public Task<IEnumerable<Sensor>> FindAllSensorsAsync()
        {
            return SubscribeRepository(() => m_sensorRepository.FindAllAsync(), "SensorAppDataHelper.FindAllSensorsAsync");
        }

        public Task<IEnumerable<Sensor>> FindSensorsByNameAsync(string name)
        {
            return SubscribeRepository(() => m_sensorRepository.FindByNameAsync(name), "SensorAppDataHelper.FindSensorsByNameAsync");
        }
        
        public Task<IEnumerable<Sensor>> FindSensorsByNameContainsAsync(string text)
        {
            return SubscribeRepository(() => m_sensorRepository.FindByNameContainsAsync(text), "SensorAppDataHelper.FindSensorsByNameContainsAsync");
        }

        public Task<Sensor> SaveSensorAsync(Sensor sensor)
        {
            return SubscribeRepository(() => m_sensorRepository.SaveAsync(sensor), "SensorAppDataHelper.SaveSensorAsync");            
        }

        public Task<Sensor> UpdatSensorAsync(Sensor sensor)
        {
            return SubscribeRepository(() => m_sensorRepository.UpdateAsync(sensor), "SensorAppDataHelper.UpdatSensoreAsync");
        }

        //...
    }
}
