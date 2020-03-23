package resources;
// Generated Mar 24, 2020 1:07:10 AM by Hibernate Tools 4.3.1



/**
 * ItemsHasRawItems generated by hbm2java
 */
public class ItemsHasRawItems  implements java.io.Serializable {


     private Integer itemsHasRawItemsId;
     private Items items;
     private RawItems rawItems;
     private Double amount;
     private Integer status;

    public ItemsHasRawItems() {
    }

	
    public ItemsHasRawItems(Items items, RawItems rawItems) {
        this.items = items;
        this.rawItems = rawItems;
    }
    public ItemsHasRawItems(Items items, RawItems rawItems, Double amount, Integer status) {
       this.items = items;
       this.rawItems = rawItems;
       this.amount = amount;
       this.status = status;
    }
   
    public Integer getItemsHasRawItemsId() {
        return this.itemsHasRawItemsId;
    }
    
    public void setItemsHasRawItemsId(Integer itemsHasRawItemsId) {
        this.itemsHasRawItemsId = itemsHasRawItemsId;
    }
    public Items getItems() {
        return this.items;
    }
    
    public void setItems(Items items) {
        this.items = items;
    }
    public RawItems getRawItems() {
        return this.rawItems;
    }
    
    public void setRawItems(RawItems rawItems) {
        this.rawItems = rawItems;
    }
    public Double getAmount() {
        return this.amount;
    }
    
    public void setAmount(Double amount) {
        this.amount = amount;
    }
    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }




}


