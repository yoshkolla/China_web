package resources;
// Generated Mar 20, 2020 3:46:21 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * User generated by hbm2java
 */
public class User  implements java.io.Serializable {


     private Integer userId;
     private Staff staff;
     private String username;
     private String password;
     private Integer status;
     private String sales;
     private String purchase;
     private String production;
     private String create;
     private String user;
     private String cheque;
     private String report;
     private String other;
     private Set grns = new HashSet(0);
     private Set invoices = new HashSet(0);

    public User() {
    }

	
    public User(Staff staff) {
        this.staff = staff;
    }
    public User(Staff staff, String username, String password, Integer status, String sales, String purchase, String production, String create, String user, String cheque, String report, String other, Set grns, Set invoices) {
       this.staff = staff;
       this.username = username;
       this.password = password;
       this.status = status;
       this.sales = sales;
       this.purchase = purchase;
       this.production = production;
       this.create = create;
       this.user = user;
       this.cheque = cheque;
       this.report = report;
       this.other = other;
       this.grns = grns;
       this.invoices = invoices;
    }
   
    public Integer getUserId() {
        return this.userId;
    }
    
    public void setUserId(Integer userId) {
        this.userId = userId;
    }
    public Staff getStaff() {
        return this.staff;
    }
    
    public void setStaff(Staff staff) {
        this.staff = staff;
    }
    public String getUsername() {
        return this.username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    public String getPassword() {
        return this.password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }
    public String getSales() {
        return this.sales;
    }
    
    public void setSales(String sales) {
        this.sales = sales;
    }
    public String getPurchase() {
        return this.purchase;
    }
    
    public void setPurchase(String purchase) {
        this.purchase = purchase;
    }
    public String getProduction() {
        return this.production;
    }
    
    public void setProduction(String production) {
        this.production = production;
    }
    public String getCreate() {
        return this.create;
    }
    
    public void setCreate(String create) {
        this.create = create;
    }
    public String getUser() {
        return this.user;
    }
    
    public void setUser(String user) {
        this.user = user;
    }
    public String getCheque() {
        return this.cheque;
    }
    
    public void setCheque(String cheque) {
        this.cheque = cheque;
    }
    public String getReport() {
        return this.report;
    }
    
    public void setReport(String report) {
        this.report = report;
    }
    public String getOther() {
        return this.other;
    }
    
    public void setOther(String other) {
        this.other = other;
    }
    public Set getGrns() {
        return this.grns;
    }
    
    public void setGrns(Set grns) {
        this.grns = grns;
    }
    public Set getInvoices() {
        return this.invoices;
    }
    
    public void setInvoices(Set invoices) {
        this.invoices = invoices;
    }




}


