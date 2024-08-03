package kr.co.soldesk.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soldesk.beans.OceanofSurfaceBean;
import kr.co.soldesk.beans.RainfallBean;
import kr.co.soldesk.beans.SeaTemperatureBean;
import kr.co.soldesk.beans.TemperatureBean;
import kr.co.soldesk.dao.WeatherDAO;

@Service
public class WeatherService {
	
	@Autowired
	WeatherDAO weatherDAO;
	
	public List<OceanofSurfaceBean> getOceanofSurface1993To1997() {
		return weatherDAO.getOceanofSurface1993To1997();
	}
	
	public List<OceanofSurfaceBean> getOceanofSurface2013To2017() {
		return weatherDAO.getOceanofSurface2013To2017();
	}
	
	public List<SeaTemperatureBean> getSeaTemperatures2017To2021() {
        return weatherDAO.getSeaTemperatures2017To2021();
    }

    public List<SeaTemperatureBean> getSeaTemperatures2022To2023() {
        return weatherDAO.getSeaTemperatures2022To2023();
    }
	
    public List<TemperatureBean> getTemperatures2017To2021() {
		return weatherDAO.getTemperatures2017To2021();
	}
	
	public List<TemperatureBean> getTemperatures2022To2023() {
		return weatherDAO.getTemperatures2022To2023();
	}
	
	public List<RainfallBean> getRainfallBeans2017To2021() {
		return weatherDAO.getRainfallBeans2017To2021();
	}
	
	public List<RainfallBean> getRainfallBeans2022To2023() {
		return weatherDAO.getRainfallBeans2022To2023();
	}
	
}
