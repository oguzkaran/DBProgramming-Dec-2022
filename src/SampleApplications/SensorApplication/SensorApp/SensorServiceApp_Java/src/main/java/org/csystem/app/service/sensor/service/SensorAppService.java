package org.csystem.app.service.sensor.service;

import org.csystem.app.service.sensor.data.dal.SensorServiceHelper;
import org.csystem.app.service.sensor.data.entity.Sensor;
import org.csystem.app.service.sensor.dto.SensorDTO;
import org.csystem.app.service.sensor.dto.SensorsDTO;
import org.csystem.app.service.sensor.mapper.ISensorDataMapper;
import org.csystem.app.service.sensor.mapper.ISensorMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import static org.csystem.util.collection.CollectionUtil.toList;
import static org.csystem.util.data.DatabaseUtil.doWorkForService;

@Service
public class SensorAppService {
    private final SensorServiceHelper m_sensorServiceHelper;
    private final ISensorMapper m_sensorMapper;
    private final ISensorDataMapper m_sensorDataMapper;

    private List<SensorDTO> findAllSensorsCallback()
    {
        return toList(m_sensorServiceHelper.findAllSensors(), m_sensorMapper::toSensorDTO, true);
    }

    private Optional<SensorDTO> findSensorByNameCallback(String name)
    {
        var so = m_sensorServiceHelper.findSensorByName(name);

        return Optional.ofNullable(m_sensorMapper.toSensorDTO(so.isEmpty() ? null : so.get()));
    }

    private List<SensorDTO> findSensorByNameContainsCallback(String text)
    {
        return toList(m_sensorServiceHelper.findSensorByNameContains(text), m_sensorMapper::toSensorDTO, false);
    }

    private SensorDTO findSensorByNameContainsDetailMapCallback(Sensor sensor)
    {
        var dto = m_sensorMapper.toSensorDTO(sensor);

        return dto;
    }

    private SensorsDTO findSensorByNameContainsCallbackDetail(String text)
    {
        return m_sensorMapper.toSensorsDTO(StreamSupport.stream(m_sensorServiceHelper.findSensorByNameContains(text).spliterator(), false)
                .map(this::findSensorByNameContainsDetailMapCallback)
                .collect(Collectors.toList()));
    }

    public SensorAppService(SensorServiceHelper sensorServiceHelper, ISensorMapper sensorMapper, ISensorDataMapper sensorDataMapper)
    {
        m_sensorServiceHelper = sensorServiceHelper;
        m_sensorMapper = sensorMapper;
        m_sensorDataMapper = sensorDataMapper;
    }

    public Optional<SensorDTO> findSensorByName(String name)
    {
        return doWorkForService(() -> findSensorByNameCallback(name), "SensorAppService.findSensorByName");
    }

    public Iterable<SensorDTO> findSensorByNameContains(String text)
    {
        return doWorkForService(() -> findSensorByNameContainsCallback(text), "SensorAppService.findSensorByName");
    }

    public SensorsDTO findSensorByNameContainsDetail(String text)
    {
        return doWorkForService(() -> findSensorByNameContainsCallbackDetail(text),
                "SensorAppService.findSensorByNameContainsDetail");
    }

    public List<SensorDTO> findAllSensors()
    {
        return doWorkForService(this::findAllSensorsCallback, "SensorAppService.findSensorByName");
    }

    public SensorsDTO findAllSensorsInfo()
    {
        return m_sensorMapper.toSensorsDTO(StreamSupport.stream(m_sensorServiceHelper.findAllSensors().spliterator(), false)
                .map(this::findSensorByNameContainsDetailMapCallback)
                .collect(Collectors.toList()));
    }


    //...
}
