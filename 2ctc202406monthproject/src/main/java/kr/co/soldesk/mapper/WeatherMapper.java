package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import kr.co.soldesk.beans.OceanofSurfaceBean;
import kr.co.soldesk.beans.RainfallBean;
import kr.co.soldesk.beans.SeaTemperatureBean;
import kr.co.soldesk.beans.TemperatureBean;

public interface WeatherMapper {
	
	@Select("select ofsweatherID, city, years, figures from oceanofsurface where years between '1993' and '1997'")
	List<OceanofSurfaceBean> getOceanofSurface1993To1997();
	
	@Select("select ofsweatherID, city, years, figures from oceanofsurface where years between '2013' and '2017'")
	List<OceanofSurfaceBean> getOceanofSurface2013To2017();
	
	@Select("SELECT stempweatherID, city, years, season, figures, latitude, longitude FROM seatemperature WHERE years = '2017-2021'")
    List<SeaTemperatureBean> getSeaTemperatures2017To2021();

    @Select("SELECT stempweatherID, city, years, season, figures, latitude, longitude FROM seatemperature WHERE years = '2022-2023'")
    List<SeaTemperatureBean> getSeaTemperatures2022To2023();
	
	@Select("select tempweatherID, city, years, season, figures from temperature where years='2017-2021'")
	List<TemperatureBean> getTemperatures2017To2021();
	
	@Select("select tempweatherID, city, years, season, figures from temperature where years = '2022-2023'")
	List<TemperatureBean> getTemperatures2022To2023();
	
	@Select("select rainweatherID, city, years, season, figures from rainfall where years='2017-2021'")
	List<RainfallBean> getRainfallBeans2017To2021();
	
	@Select("select rainweatherID, city, years, season, figures from rainfall where years='2022-2023'")
	List<RainfallBean> getRainfallBeans2022To2023();
	
}
