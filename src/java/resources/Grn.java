package resources;
// Generated Mar 24, 2020 1:07:10 AM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Grn generated by hbm2java
 */
public class Grn  implements java.io.Serializable {


     private Integer grnId;
     private Supplier supplier;
     private User user;
     private Double total;
     private Double cash;
     private Double balance;
     private String date;
     private String time;
     private Double discount;
     private Double netTotal;
     private Integer status;
     private Set grnItems = new HashSet(0);
     private Set grnPayments = new HashSet(0);

    public Grn() {
    }

	
    public Grn(Supplier supplier, User user) {
        this.supplier = supplier;
        this.user = user;
    }
    public Grn(Supplier supplier, User user, Double total, Double cash, Double balance, String date, String time, Double discount, Double netTotal, Integer status, Set grnItems, Set grnPayments) {
       this.supplier = supplier;
       this.user = user;
       this.total = total;
       this.cash = cash;
       this.balance = balance;
       this.date = date;
       this.time = time;
       this.discount = discount;
       this.netTotal = netTotal;
       this.status = status;
       this.grnItems = grnItems;
       this.grnPayments = grnPayments;
    }
   
    public Integer getGrnId() {
        return this.grnId;
    }
    
    public void setGrnId(Integer grnId) {
        this.grnId = grnId;
    }
    public Supplier getSupplier() {
        return this.supplier;
    }
    
    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public Double getTotal() {
        return this.total;
    }
    
    public void setTotal(Double total) {
        this.total = total;
    }
    public Double getCash() {
        return this.cash;
    }
    
    public void setCash(Double cash) {
        this.cash = cash;
    }
    public Double getBalance() {
        return this.balance;
    }
    
    public void setBalance(Double balance) {
        this.balance = balance;
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
    public Set getGrnItems() {
        return this.grnItems;
    }
    
    public void setGrnItems(Set grnItems) {
        this.grnItems = grnItems;
    }
    public Set getGrnPayments() {
        return this.grnPayments;
    }
    
    public void setGrnPayments(Set grnPayments) {
        this.grnPayments = grnPayments;
    }




}


