package resources;
// Generated Mar 22, 2020 2:49:48 AM by Hibernate Tools 4.3.1



/**
 * RawStock generated by hbm2java
 */
public class RawStock  implements java.io.Serializable {


     private Integer rawStockId;
     private RawItems rawItems;
     private Double cost;
     private String date;
     private String time;
     private Double qty;

    public RawStock() {
    }

	
    public RawStock(RawItems rawItems) {
        this.rawItems = rawItems;
    }
    public RawStock(RawItems rawItems, Double cost, String date, String time, Double qty) {
       this.rawItems = rawItems;
       this.cost = cost;
       this.date = date;
       this.time = time;
       this.qty = qty;
    }
   
    public Integer getRawStockId() {
        return this.rawStockId;
    }
    
    public void setRawStockId(Integer rawStockId) {
        this.rawStockId = rawStockId;
    }
    public RawItems getRawItems() {
        return this.rawItems;
    }
    
    public void setRawItems(RawItems rawItems) {
        this.rawItems = rawItems;
    }
    public Double getCost() {
        return this.cost;
    }
    
    public void setCost(Double cost) {
        this.cost = cost;
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
    public Double getQty() {
        return this.qty;
    }
    
    public void setQty(Double qty) {
        this.qty = qty;
    }




}


