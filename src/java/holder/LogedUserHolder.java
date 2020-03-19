/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package holder;

/**
 *
 * @author Mayura Lakshan
 */
public class LogedUserHolder {
    int userId , StafId;
    String Name,Username,Sales, Purchase ,Production , Create , User , Cheque , Report , Other;

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getStafId() {
        return StafId;
    }

    public void setStafId(int StafId) {
        this.StafId = StafId;
    }

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    public String getUsername() {
        return Username;
    }

    public void setUsername(String Username) {
        this.Username = Username;
    }

    public String getSales() {
        return Sales;
    }

    public void setSales(String Sales) {
        this.Sales = Sales;
    }

    public String getPurchase() {
        return Purchase;
    }

    public void setPurchase(String Purchase) {
        this.Purchase = Purchase;
    }

    public String getProduction() {
        return Production;
    }

    public void setProduction(String Production) {
        this.Production = Production;
    }

    public String getCreate() {
        return Create;
    }

    public void setCreate(String Create) {
        this.Create = Create;
    }

    public String getUser() {
        return User;
    }

    public void setUser(String User) {
        this.User = User;
    }

    public String getCheque() {
        return Cheque;
    }

    public void setCheque(String Cheque) {
        this.Cheque = Cheque;
    }

    public String getReport() {
        return Report;
    }

    public void setReport(String Report) {
        this.Report = Report;
    }

    public String getOther() {
        return Other;
    }

    public void setOther(String Other) {
        this.Other = Other;
    }

    /**
     *
     * @param userId
     * @param StafId
     * @param Name
     * @param Username
     * @param Sales
     * @param Purchase
     * @param Production
     * @param Create
     * @param User
     * @param Cheque
     * @param Report
     * @param Other
     */
    public LogedUserHolder(int userId, int StafId, String Name, String Username, String Sales, String Purchase, String Production, String Create, String User, String Cheque, String Report, String Other) {
        this.userId = userId;
        this.StafId = StafId;
        this.Name = Name;
        this.Username = Username;
        this.Sales = Sales;
        this.Purchase = Purchase;
        this.Production = Production;
        this.Create = Create;
        this.User = User;
        this.Cheque = Cheque;
        this.Report = Report;
        this.Other = Other;
    }

    public LogedUserHolder() {
    }
    
}
