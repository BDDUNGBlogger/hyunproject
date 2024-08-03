package kr.co.soldesk.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.OceanofSurfaceBean;
import kr.co.soldesk.beans.RainfallBean;
import kr.co.soldesk.beans.SeaTemperatureBean;
import kr.co.soldesk.beans.TemperatureBean;
import kr.co.soldesk.mapper.WeatherMapper;

@Repository
public class WeatherDAO {
	
	@Autowired
	WeatherMapper weatherMapper;
	
	public List<OceanofSurfaceBean> getOceanofSurface1993To1997() {
		return weatherMapper.getOceanofSurface1993To1997();
	}
	
	public List<OceanofSurfaceBean> getOceanofSurface2013To2017() {
		return weatherMapper.getOceanofSurface2013To2017();
	}
	
    public List<SeaTemperatureBean> getSeaTemperatures2017To2021() {
        return weatherMapper.getSeaTemperatures2017To2021();
    }

    public List<SeaTemperatureBean> getSeaTemperatures2022To2023() {
        return weatherMapper.getSeaTemperatures2022To2023();
    }
	
	public List<TemperatureBean> getTemperatures2017To2021() {
		return weatherMapper.getTemperatures2017To2021();
	}
	
	public List<TemperatureBean> getTemperatures2022To2023() {
		return weatherMapper.getTemperatures2022To2023();
	}
	
	public List<RainfallBean> getRainfallBeans2017To2021() {
		return weatherMapper.getRainfallBeans2017To2021();
	}
	
	public List<RainfallBean> getRainfallBeans2022To2023() {
		return weatherMapper.getRainfallBeans2022To2023();
	}
	
	
}
