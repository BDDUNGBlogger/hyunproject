package kr.co.soldesk.beans;

public class SeaTemperatureBean {
    private String stempweatherID;
    private String city;
    private String years;
    private String season;
    private String figures;
    private float latitude;
    private float longitude;

    // Getters and Setters

    public String getStempweatherID() {
        return stempweatherID;
    }

    public void setStempweatherID(String stempweatherID) {
        this.stempweatherID = stempweatherID;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getYears() {
        return years;
    }

    public void setYears(String years) {
        this.years = years;
    }

    public String getSeason() {
        return season;
    }

    public void setSeason(String season) {
        this.season = season;
    }

    public String getFigures() {
        return figures;
    }

    public void setFigures(String figures) {
        this.figures = figures;
    }

    public float getLatitude() {
        return latitude;
    }

    public void setLatitude(float latitude) {
        this.latitude = latitude;
    }

    public float getLongitude() {
        return longitude;
    }

    public void setLongitude(float longitude) {
        this.longitude = longitude;
    }
}
