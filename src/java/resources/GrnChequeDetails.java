package resources;
// Generated Mar 22, 2020 2:49:48 AM by Hibernate Tools 4.3.1



/**
 * GrnChequeDetails generated by hbm2java
 */
public class GrnChequeDetails  implements java.io.Serializable {


     private Integer grnChequeDetailsId;
     private GrnPayment grnPayment;
     private String type;
     private String chequeNo;
     private String chequeDate;
     private String bank;
     private String branch;
     private Double amount;
     private Integer status;

    public GrnChequeDetails() {
    }

	
    public GrnChequeDetails(GrnPayment grnPayment) {
        this.grnPayment = grnPayment;
    }
    public GrnChequeDetails(GrnPayment grnPayment, String type, String chequeNo, String chequeDate, String bank, String branch, Double amount, Integer status) {
       this.grnPayment = grnPayment;
       this.type = type;
       this.chequeNo = chequeNo;
       this.chequeDate = chequeDate;
       this.bank = bank;
       this.branch = branch;
       this.amount = amount;
       this.status = status;
    }
   
    public Integer getGrnChequeDetailsId() {
        return this.grnChequeDetailsId;
    }
    
    public void setGrnChequeDetailsId(Integer grnChequeDetailsId) {
        this.grnChequeDetailsId = grnChequeDetailsId;
    }
    public GrnPayment getGrnPayment() {
        return this.grnPayment;
    }
    
    public void setGrnPayment(GrnPayment grnPayment) {
        this.grnPayment = grnPayment;
    }
    public String getType() {
        return this.type;
    }
    
    public void setType(String type) {
        this.type = type;
    }
    public String getChequeNo() {
        return this.chequeNo;
    }
    
    public void setChequeNo(String chequeNo) {
        this.chequeNo = chequeNo;
    }
    public String getChequeDate() {
        return this.chequeDate;
    }
    
    public void setChequeDate(String chequeDate) {
        this.chequeDate = chequeDate;
    }
    public String getBank() {
        return this.bank;
    }
    
    public void setBank(String bank) {
        this.bank = bank;
    }
    public String getBranch() {
        return this.branch;
    }
    
    public void setBranch(String branch) {
        this.branch = branch;
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


