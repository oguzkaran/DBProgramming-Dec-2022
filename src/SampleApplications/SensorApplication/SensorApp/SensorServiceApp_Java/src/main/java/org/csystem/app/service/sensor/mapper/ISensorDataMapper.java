package org.csystem.app.service.sensor.mapper;

import org.csystem.app.service.sensor.data.entity.SensorData;
import org.csystem.app.service.sensor.dto.SensorDataDTO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.Set;

@Mapper(implementationName = "SensorDataImpl", componentModel = "spring")
public interface ISensorDataMapper {
    @Mapping(source = "value", target = "data")
    @Mapping(source = "readDateTime", target = "dataDateTime", dateFormat = "dd/MM/yyyy hh:mm:ss")
    SensorDataDTO toSensorDataDTO(SensorData sensorData);

    @Mapping(target = "value", source = "data")
    @Mapping(target = "readDateTime", source = "dataDateTime", dateFormat = "dd/MM/yyyy hh:mm:ss")
    SensorData toSensorData(SensorDataDTO sensorDataDTO);

    Set<SensorDataDTO> toSensorDataDTOs(Set<SensorData> sensorData);
}
