package resources;
// Generated Mar 20, 2020 3:46:21 PM by Hibernate Tools 4.3.1



/**
 * GrnItem generated by hbm2java
 */
public class GrnItem  implements java.io.Serializable {


     private Integer grnItemId;
     private Grn grn;
     private RawItems rawItems;
     private Double unitPrice;
     private Double cost;
     private Double qty;
     private Double total;
     private Double discount;
     private Double netTotal;
     private Integer status;

    public GrnItem() {
    }

	
    public GrnItem(Grn grn, RawItems rawItems) {
        this.grn = grn;
        this.rawItems = rawItems;
    }
    public GrnItem(Grn grn, RawItems rawItems, Double unitPrice, Double cost, Double qty, Double total, Double discount, Double netTotal, Integer status) {
       this.grn = grn;
       this.rawItems = rawItems;
       this.unitPrice = unitPrice;
       this.cost = cost;
       this.qty = qty;
       this.total = total;
       this.discount = discount;
       this.netTotal = netTotal;
       this.status = status;
    }
   
    public Integer getGrnItemId() {
        return this.grnItemId;
    }
    
    public void setGrnItemId(Integer grnItemId) {
        this.grnItemId = grnItemId;
    }
    public Grn getGrn() {
        return this.grn;
    }
    
    public void setGrn(Grn grn) {
        this.grn = grn;
    }
    public RawItems getRawItems() {
        return this.rawItems;
    }
    
    public void setRawItems(RawItems rawItems) {
        this.rawItems = rawItems;
    }
    public Double getUnitPrice() {
        return this.unitPrice;
    }
    
    public void setUnitPrice(Double unitPrice) {
        this.unitPrice = unitPrice;
    }
    public Double getCost() {
        return this.cost;
    }
    
    public void setCost(Double cost) {
        this.cost = cost;
    }
    public Double getQty() {
        return this.qty;
    }
    
    public void setQty(Double qty) {
        this.qty = qty;
    }
    public Double getTotal() {
        return this.total;
    }
    
    public void setTotal(Double total) {
        this.total = total;
    }
    public Double getDiscount() {
        return this.discount;
    }
    
    public void setDiscount(Double discount) {
        this.discount = discount;
    }
    public Double getNetTotal() {
        return this.netTotal;
    }
    
    public void setNetTotal(Double netTotal) {
        this.netTotal = netTotal;
    }
    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }




}


