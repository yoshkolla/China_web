package resources;
// Generated Mar 24, 2020 1:07:10 AM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Production generated by hbm2java
 */
public class Production  implements java.io.Serializable {


     private Integer productionId;
     private Items items;
     private String date;
     private String time;
     private Double salePrice;
     private Double qty;
     private Double totalCost;
     private Double totalLabourCost;
     private Double companyCost;
     private Integer status;
     private Set productionRawItemses = new HashSet(0);
     private Set productionStaffs = new HashSet(0);

    public Production() {
    }

	
    public Production(Items items) {
        this.items = items;
    }
    public Production(Items items, String date, String time, Double salePrice, Double qty, Double totalCost, Double totalLabourCost, Double companyCost, Integer status, Set productionRawItemses, Set productionStaffs) {
       this.items = items;
       this.date = date;
       this.time = time;
       this.salePrice = salePrice;
       this.qty = qty;
       this.totalCost = totalCost;
       this.totalLabourCost = totalLabourCost;
       this.companyCost = companyCost;
       this.status = status;
       this.productionRawItemses = productionRawItemses;
       this.productionStaffs = productionStaffs;
    }
   
    public Integer getProductionId() {
        return this.productionId;
    }
    
    public void setProductionId(Integer productionId) {
        this.productionId = productionId;
    }
    public Items getItems() {
        return this.items;
    }
    
    public void setItems(Items items) {
        this.items = items;
    }
    public String getDate() {
        return this.date;
    }
    
    public void setDate(String date) {
        this.date = date;
    }
    public String getTime() {
        return this.time;
    }
    
    public void setTime(String time) {
        this.time = time;
    }
    public Double getSalePrice() {
        return this.salePrice;
    }
    
    public void setSalePrice(Double salePrice) {
        this.salePrice = salePrice;
    }
    public Double getQty() {
        return this.qty;
    }
    
    public void setQty(Double qty) {
        this.qty = qty;
    }
    public Double getTotalCost() {
        return this.totalCost;
    }
    
    public void setTotalCost(Double totalCost) {
        this.totalCost = totalCost;
    }
    public Double getTotalLabourCost() {
        return this.totalLabourCost;
    }
    
    public void setTotalLabourCost(Double totalLabourCost) {
        this.totalLabourCost = totalLabourCost;
    }
    public Double getCompanyCost() {
        return this.companyCost;
    }
    
    public void setCompanyCost(Double companyCost) {
        this.companyCost = companyCost;
    }
    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }
    public Set getProductionRawItemses() {
        return this.productionRawItemses;
    }
    
    public void setProductionRawItemses(Set productionRawItemses) {
        this.productionRawItemses = productionRawItemses;
    }
    public Set getProductionStaffs() {
        return this.productionStaffs;
    }
    
    public void setProductionStaffs(Set productionStaffs) {
        this.productionStaffs = productionStaffs;
    }




}


