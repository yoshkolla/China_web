package resources;
// Generated Mar 20, 2020 3:46:21 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * InvoicePayment generated by hbm2java
 */
public class InvoicePayment  implements java.io.Serializable {


     private Integer invoicePaymentId;
     private Invoice invoice;
     private PaymentType paymentType;
     private String date;
     private String time;
     private Double amount;
     private Integer status;
     private Set invoiceChequeDetailses = new HashSet(0);

    public InvoicePayment() {
    }

	
    public InvoicePayment(Invoice invoice, PaymentType paymentType) {
        this.invoice = invoice;
        this.paymentType = paymentType;
    }
    public InvoicePayment(Invoice invoice, PaymentType paymentType, String date, String time, Double amount, Integer status, Set invoiceChequeDetailses) {
       this.invoice = invoice;
       this.paymentType = paymentType;
       this.date = date;
       this.time = time;
       this.amount = amount;
       this.status = status;
       this.invoiceChequeDetailses = invoiceChequeDetailses;
    }
   
    public Integer getInvoicePaymentId() {
        return this.invoicePaymentId;
    }
    
    public void setInvoicePaymentId(Integer invoicePaymentId) {
        this.invoicePaymentId = invoicePaymentId;
    }
    public Invoice getInvoice() {
        return this.invoice;
    }
    
    public void setInvoice(Invoice invoice) {
        this.invoice = invoice;
    }
    public PaymentType getPaymentType() {
        return this.paymentType;
    }
    
    public void setPaymentType(PaymentType paymentType) {
        this.paymentType = paymentType;
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
    public Set getInvoiceChequeDetailses() {
        return this.invoiceChequeDetailses;
    }
    
    public void setInvoiceChequeDetailses(Set invoiceChequeDetailses) {
        this.invoiceChequeDetailses = invoiceChequeDetailses;
    }




}


