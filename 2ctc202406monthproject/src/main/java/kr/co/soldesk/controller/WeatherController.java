package kr.co.soldesk.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.soldesk.beans.OceanofSurfaceBean;
import kr.co.soldesk.beans.RainfallBean;
import kr.co.soldesk.beans.SeaTemperatureBean;
import kr.co.soldesk.beans.TemperatureBean;
import kr.co.soldesk.service.WeatherService;

@Controller
@RequestMapping("/weather")
public class WeatherController {
	
	@Autowired
	private WeatherService weatherService;
	
	@GetMapping("/surfaceofthesea")
	public String oceanofsurface(@RequestParam(value = "ofsweatherID", required = false) String ofsweatherID, Model model) {
		List<OceanofSurfaceBean> OceanofSurface1993To1997 = weatherService.getOceanofSurface1993To1997();
		List<OceanofSurfaceBean> OceanofSurface2013To2017 = weatherService.getOceanofSurface2013To2017();
		
		model.addAttribute("OceanofSurface1993To1997", OceanofSurface1993To1997);
		model.addAttribute("OceanofSurface2013To2017", OceanofSurface2013To2017);
		
		return "weather/surfaceofthesea";
	}
	
	@GetMapping("/seatemperature")
	public String seatemperature(@RequestParam(value = "stempweatherID", required = false) String stempweatherID, Model model) {
		
		List<SeaTemperatureBean> SeaTemperatureList2017To2021 = weatherService.getSeaTemperatures2017To2021();
        List<SeaTemperatureBean> SeaTemperatureList2022To2023 = weatherService.getSeaTemperatures2022To2023();
        model.addAttribute("SeaTemperatureList2017To2021", SeaTemperatureList2017To2021);
        model.addAttribute("SeaTemperatureList2022To2023", SeaTemperatureList2022To2023);
        return "weather/seatemperature";
	}
	
	@GetMapping("/temperature")
	public String temperature(@RequestParam(value = "tempweatherID", required = false) String tempweatherID, Model model) {
	
	List<TemperatureBean> Temperatures2017To2021 = weatherService.getTemperatures2017To2021();
	List<TemperatureBean> Temperatures2022To2023 = weatherService.getTemperatures2022To2023();
		
	model.addAttribute("Temperatures2017To2021", Temperatures2017To2021);
	model.addAttribute("Temperatures2022To2023", Temperatures2022To2023);
		
		return "weather/temperature";
	}
	
	@GetMapping("/rainfall")
	public String rainfall(@RequestParam(value = "rainweatherID", required = false) String rainweatherID, Model model) {
		List<RainfallBean> RainfallBeans2017To2021 = weatherService.getRainfallBeans2017To2021();
		List<RainfallBean> RainfallBeans2022To2023 = weatherService.getRainfallBeans2022To2023();
		
		model.addAttribute("RainfallBeans2017To2021", RainfallBeans2017To2021);
		model.addAttribute("RainfallBeans2022To2023", RainfallBeans2022To2023);
		
		return "weather/rainfall";
	}
	
	
}
