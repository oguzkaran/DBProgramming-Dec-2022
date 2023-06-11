package org.csystem.app.service.sensor.data.repository;

import org.csystem.app.service.sensor.data.entity.SensorData;
import org.springframework.data.repository.CrudRepository;

public interface ISensorDataRepository extends CrudRepository<SensorData, Long> {

}
