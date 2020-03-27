package resources;
// Generated Mar 28, 2020 12:36:20 AM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Items generated by hbm2java
 */
public class Items  implements java.io.Serializable {


     private Integer itemsId;
     private MeasurementType measurementType;
     private String name;
     private String image;
     private Double rol;
     private String status;
     private Set itemStaffCosts = new HashSet(0);
     private Set itemsHasRawItemses = new HashSet(0);
     private Set productionStepses = new HashSet(0);
     private Set stocks = new HashSet(0);
     private Set productions = new HashSet(0);

    public Items() {
    }

	
    public Items(MeasurementType measurementType) {
        this.measurementType = measurementType;
    }
    public Items(MeasurementType measurementType, String name, String image, Double rol, String status, Set itemStaffCosts, Set itemsHasRawItemses, Set productionStepses, Set stocks, Set productions) {
       this.measurementType = measurementType;
       this.name = name;
       this.image = image;
       this.rol = rol;
       this.status = status;
       this.itemStaffCosts = itemStaffCosts;
       this.itemsHasRawItemses = itemsHasRawItemses;
       this.productionStepses = productionStepses;
       this.stocks = stocks;
       this.productions = productions;
    }
   
    public Integer getItemsId() {
        return this.itemsId;
    }
    
    public void setItemsId(Integer itemsId) {
        this.itemsId = itemsId;
    }
    public MeasurementType getMeasurementType() {
        return this.measurementType;
    }
    
    public void setMeasurementType(MeasurementType measurementType) {
        this.measurementType = measurementType;
    }
    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    public String getImage() {
        return this.image;
    }
    
    public void setImage(String image) {
        this.image = image;
    }
    public Double getRol() {
        return this.rol;
    }
    
    public void setRol(Double rol) {
        this.rol = rol;
    }
    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    public Set getItemStaffCosts() {
        return this.itemStaffCosts;
    }
    
    public void setItemStaffCosts(Set itemStaffCosts) {
        this.itemStaffCosts = itemStaffCosts;
    }
    public Set getItemsHasRawItemses() {
        return this.itemsHasRawItemses;
    }
    
    public void setItemsHasRawItemses(Set itemsHasRawItemses) {
        this.itemsHasRawItemses = itemsHasRawItemses;
    }
    public Set getProductionStepses() {
        return this.productionStepses;
    }
    
    public void setProductionStepses(Set productionStepses) {
        this.productionStepses = productionStepses;
    }
    public Set getStocks() {
        return this.stocks;
    }
    
    public void setStocks(Set stocks) {
        this.stocks = stocks;
    }
    public Set getProductions() {
        return this.productions;
    }
    
    public void setProductions(Set productions) {
        this.productions = productions;
    }




}


