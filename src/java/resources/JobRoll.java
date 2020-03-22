package resources;
// Generated Mar 22, 2020 2:49:48 AM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * JobRoll generated by hbm2java
 */
public class JobRoll  implements java.io.Serializable {


     private Integer jobRollId;
     private String name;
     private Integer status;
     private Set staffs = new HashSet(0);

    public JobRoll() {
    }

    public JobRoll(String name, Integer status, Set staffs) {
       this.name = name;
       this.status = status;
       this.staffs = staffs;
    }
   
    public Integer getJobRollId() {
        return this.jobRollId;
    }
    
    public void setJobRollId(Integer jobRollId) {
        this.jobRollId = jobRollId;
    }
    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }
    public Set getStaffs() {
        return this.staffs;
    }
    
    public void setStaffs(Set staffs) {
        this.staffs = staffs;
    }




}


