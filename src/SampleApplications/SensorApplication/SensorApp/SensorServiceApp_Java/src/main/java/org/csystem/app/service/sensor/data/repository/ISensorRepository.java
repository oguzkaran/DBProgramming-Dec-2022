package org.csystem.app.service.sensor.data.repository;

import org.csystem.app.service.sensor.data.entity.Sensor;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

public interface ISensorRepository extends CrudRepository<Sensor, Integer> {
    //@Query("select s from Sensor s where s.name like :name")
    Optional<Sensor> findByName(String name);
    Iterable<Sensor> findByNameContains(String text);
}
