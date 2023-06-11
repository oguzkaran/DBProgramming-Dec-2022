using CSD.SensorApp.Data.DTO;
using CSD.Util.Mappers;
using Microsoft.Extensions.DependencyInjection;
using SensorAppDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using static CSD.Data.DatabaseUtil;

namespace CSD.SensorApp.Data.Service
{
    public class SensorAppService
    {
        private readonly SensorAppDataHelper m_sensorAppDataHelper;
        private readonly IMapper m_mapper;

        private async Task<SensorSaveDTO> saveSensorAsync(SensorSaveDTO sensorDTO)
        {
            var sensor = m_mapper.Map<Sensor, SensorSaveDTO>(sensorDTO);

            return m_mapper.Map<SensorSaveDTO, Sensor>(await m_sensorAppDataHelper.SaveSensorAsync(sensor));           
        }

        private async Task<SensorInfoDTO> updateSensorAsync(SensorInfoDTO sensorDTO)
        {
            var sensor = m_mapper.Map<Sensor, SensorInfoDTO>(sensorDTO);

            return m_mapper.Map<SensorInfoDTO, Sensor>(await m_sensorAppDataHelper.UpdatSensorAsync(sensor));
        }

        private async Task<IEnumerable<SensorInfoDTO>> findSensorsAsync()
        {
            var sensors = await m_sensorAppDataHelper.FindAllSensorsAsync();

            return sensors.Select(s => m_mapper.Map<SensorInfoDTO, Sensor>(s));
        }

        private async Task<IEnumerable<SensorInfoDTO>> findSensorsByNameAsync(string name)
        {
            var sensors = await m_sensorAppDataHelper.FindSensorsByNameAsync(name);

            return sensors.Select(s => m_mapper.Map<SensorInfoDTO, Sensor>(s));
        }

        private async Task<IEnumerable<SensorInfoDTO>> findSensorsByNameContainsAsync(string text)
        {
            var sensors = await m_sensorAppDataHelper.FindSensorsByNameContainsAsync(text);

            return sensors.Select(s => m_mapper.Map<SensorInfoDTO, Sensor>(s));
        }

        public SensorAppService(SensorAppDataHelper sensorAppDataHelper, IMapper mapper)
        {
            m_sensorAppDataHelper = sensorAppDataHelper;
            m_mapper = mapper;
        }
        

        public Task<IEnumerable<SensorInfoDTO>> FindAllSensorsAsync()
        {
            return SubscribeServiceAsync(findSensorsAsync, "SensorAppDataHelper.FindAllSensorsAsync");
        }
        public Task<IEnumerable<SensorInfoDTO>> FindSensorsByNameAsync(string name)
        {
            return SubscribeServiceAsync(() => findSensorsByNameAsync(name), "SensorAppService.FindSensorsByNameAsync");
        }

        public Task<IEnumerable<SensorInfoDTO>> FindSensorsByNameContainsAsync(string text)
        {
            return SubscribeServiceAsync(() => findSensorsByNameContainsAsync(text), "SensorAppService.FindSensorsByNameContainsAsync");
        }

        public Task<SensorSaveDTO> SaveSensorAsync(SensorSaveDTO sensor)
        {
            return SubscribeServiceAsync(() => saveSensorAsync(sensor), "SensorAppService.SaveSensorAsync");
        }

        public Task<SensorInfoDTO> UpdateSensorAsync(SensorInfoDTO sensor)
        {
            return SubscribeServiceAsync(() => updateSensorAsync(sensor), "SensorAppService.UpdateSensorAsync");
        }
        //...
    }
}
