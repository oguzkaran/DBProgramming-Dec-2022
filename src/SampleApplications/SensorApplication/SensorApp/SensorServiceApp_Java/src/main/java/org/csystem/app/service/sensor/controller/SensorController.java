package org.csystem.app.service.sensor.controller;

import org.csystem.app.service.sensor.dto.SensorDTO;
import org.csystem.app.service.sensor.dto.SensorInfoNotFoundDTO;
import org.csystem.app.service.sensor.dto.SensorsDTO;
import org.csystem.app.service.sensor.service.SensorAppService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("api/sensors")
public class SensorController {
    private final SensorAppService m_sensorAppService;

    public SensorController(SensorAppService sensorAppService)
    {
        m_sensorAppService = sensorAppService;
    }

    @GetMapping("sensor/all")
    //@PreAdminOrSystem
    public List<SensorDTO> findAllSensors()
    {
        return m_sensorAppService.findAllSensors();
    }

    @GetMapping("sensors")
    //@PreAdminOrSystem
    public SensorsDTO findAllSensorsInfo()
    {
        return m_sensorAppService.findAllSensorsInfo();
    }

    @GetMapping("sensor/name")
    //@PreAuthorize("hasRole('ADMIN')")
    public Object findSensorByName(String name)
    {
        var so = m_sensorAppService.findSensorByName(name);

        return so.isPresent() ? so : new SensorInfoNotFoundDTO(name, "Sensor not found");
    }

    @GetMapping("sensor/contains")
    //@RolesAllowed({"ADMIN", "USER"})
    public Iterable<SensorDTO> findSensorsByNameContains(String text)
    {
        return m_sensorAppService.findSensorByNameContains(text);
    }

    @GetMapping("sensor/detail/contains")
    //@Secured({"ROLE_SYSTEM", "ROLE_VIEWER"})
    public SensorsDTO findSensorsByNameContainsDetail(String text)
    {
        return m_sensorAppService.findSensorByNameContainsDetail(text);
    }
}
